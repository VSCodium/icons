interface LayoutProps {
	children: React.ReactNode
}

export function Layout({ children }: LayoutProps) {
	return (
		<>
			<main>{children}</main>
		</>
	)
}
