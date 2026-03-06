const { spawnSync, spawn } = require("child_process");

const importResult = spawnSync(
  "n8n",
  ["import:workflow", "--input=/workflows", "--separate"],
  { stdio: "inherit" }
);

if (importResult.status !== 0) {
  console.error("❌ Falló la importación de workflows");
  process.exit(importResult.status || 1);
}

console.log("✅ Workflows importados correctamente");

const app = spawn("n8n", ["start"], { stdio: "inherit" });

app.on("exit", (code) => {
  process.exit(code ?? 0);
});
