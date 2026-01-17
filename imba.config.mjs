import { VitePWA } from "vite-plugin-pwa";

export default {
	bundler: "vite",
	client: {
		// Any vite config can be put in client object in order to configure the bundling.
		// It will be merged with the default config bundled with imba
		plugins: [VitePWA()], // same for plugins
		base: "/meals/",
	},
	// server: {}
}