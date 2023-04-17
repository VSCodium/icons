import { NavItem } from "@/types/nav"

interface SiteConfig {
	name: string
	description: string
	mainNav: NavItem[]
}

export const siteConfig: SiteConfig = {
	name: "Preview",
	description: "",
	mainNav: [
		{
			title: "Home",
			href: "/",
		},
	],
}
