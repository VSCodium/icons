/** @type {import('next').NextConfig} */

import { PHASE_PRODUCTION_BUILD } from 'next/constants.js'

const nextConfig = (phase) => {
	return {
		reactStrictMode: true,
		experimental: {
			fontLoaders: [
				{
					loader: "@next/font/google",
					options: { subsets: ["latin"] },
				},
			],
		},
		env: {
			IS_PRODUCTION: phase === PHASE_PRODUCTION_BUILD,
		}
	}
}

export default nextConfig
