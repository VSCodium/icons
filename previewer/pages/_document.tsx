import { Head, Html, Main, NextScript } from "next/document"

export default function Document() {
	return (
		<Html lang="en">
			<Head>
				<meta name="viewport" content="width=device-width, initial-scale=1" />
			</Head>
			<body className="min-h-screen bg-slate-50 font-sans text-slate-900 antialiased">
				<Main />
				<NextScript />
			</body>
		</Html>
	)
}
