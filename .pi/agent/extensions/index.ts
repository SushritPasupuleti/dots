import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("session_start", async (_event, ctx) => {
    ctx.ui.notify("Loaded my global pi extension from dots repo", "info");
  });

  pi.registerCommand("hello-pi", {
    description: "Say hello from my personal pi config",
    handler: async (_args, ctx) => {
      ctx.ui.notify("Hello from my pi dotfiles!", "info");
    },
  });
}
