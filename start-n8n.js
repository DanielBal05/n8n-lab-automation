const fs = require("fs");
const path = require("path");
const { spawnSync, spawn } = require("child_process");

const workflowsDir = "/workflows";

function runN8n(args) {
  const possibleBins = ["n8n", "/usr/local/bin/n8n"];

  for (const bin of possibleBins) {
    const result = spawnSync(bin, args, { stdio: "inherit" });

    if (result.error && result.error.code === "ENOENT") {
      continue;
    }

    return result;
  }

  console.error("❌ No se encontró el binario de n8n");
  return { status: 1 };
}

try {
  if (fs.existsSync(workflowsDir)) {
    const files = fs
      .readdirSync(workflowsDir)
      .filter((file) => file.toLowerCase().endsWith(".json"));

    console.log(`📦 Encontrados ${files.length} workflow(s) en ${workflowsDir}`);

    for (const file of files) {
      const fullPath = path.join(workflowsDir, file);
      console.log(`➡️ Importando: ${fullPath}`);

      const result = runN8n(["import:workflow", "--input", fullPath]);

      if (result.status !== 0) {
        console.error(`⚠️ Falló la importación de ${file}, pero n8n seguirá arrancando`);
      }
    }
  } else {
    console.log("ℹ️ No existe la carpeta /workflows, se arrancará n8n sin importar workflows");
  }
} catch (err) {
  console.error("⚠️ Error leyendo/importando workflows:", err);
}

console.log("🚀 Iniciando n8n...");

const app = spawn("n8n", ["start"], { stdio: "inherit" });

app.on("exit", (code) => {
  process.exit(code ?? 0);
});

app.on("error", (err) => {
  console.error("❌ Error arrancando n8n:", err);
  process.exit(1);
});
