import { useState } from 'react'
import Head from 'next/head'

import { siteConfig } from '@/config/site'
import { Layout } from '@/components/layout'
import { PreviewAppIcon } from '@/components/ui/preview-app-icon'
import Select from 'react-select'

import platforms from '@/config/platforms.json'
import shapes from '@/config/shapes.json'
import colors from '@/config/colors.json'
import backgrounds from '@/config/backgrounds.json'

function isLimited(limits: { backgrounds?: string[]; colors?: string[] } | undefined, background: string, color: string) { // {{{
	if(!limits) {
		return false
	}

	if(limits.backgrounds && !limits.backgrounds.includes(background)) {
		return true
	}

	if(limits.colors && !limits.colors.includes(color)) {
		return true
	}

	return false
} // }}}

export default function IndexPage() {
	const [selectedPlaforms, setSelectedPlaforms] = useState([])
	const [selectedShapes, setSelectedShapes] = useState(shapes.filter(({ value }) => value === 'paulo22s' || value === 'paulo22sb'))
	const [selectedColors, setSelectedColors] = useState(colors.filter(({ value }) => value === 'blue1'))
	const [selectedBackgrounds, setSelectedBackgrounds] = useState(backgrounds.filter(({ value }) => value === 'nobg' || value === 'circle1'))

	return (
		<Layout>
			<Head>
				<title>{siteConfig.name}</title>
			</Head>
			<header className="sticky top-0 z-40 w-full border-b border-b-slate-400 bg-slate-200">
      			<div className="container flex h-16 items-center space-x-4 sm:justify-between sm:space-x-0">
					<div className="flex flex-row items-center gap-1">
						<label htmlFor="platforms">Platform:</label>
						<Select
							id="platforms"
							options={platforms}
							defaultValue={selectedPlaforms}
							// @ts-ignore
        					onChange={setSelectedPlaforms}
							isClearable
							isMulti
							isSearchable
						/>
					</div>
					<div className="flex flex-row items-center gap-1">
						<label htmlFor="shapes">Shape:</label>
						<Select
							id="shapes"
							options={shapes}
							defaultValue={selectedShapes}
							// @ts-ignore
        					onChange={setSelectedShapes}
							isClearable
							isMulti
							isSearchable
						/>
					</div>
					<div className="flex flex-row items-center gap-1">
						<label htmlFor="colors">Color:</label>
						<Select
							id="colors"
							options={colors}
							defaultValue={selectedColors}
							// @ts-ignore
        					onChange={setSelectedColors}
							isClearable
							isMulti
							isSearchable
						/>
					</div>
					<div className="flex flex-row items-center gap-1">
						<label htmlFor="backgrounds">Background:</label>
						<Select
							id="backgrounds"
							options={backgrounds}
							defaultValue={selectedBackgrounds}
							// @ts-ignore
        					onChange={setSelectedBackgrounds}
							isClearable
							isMulti
							isSearchable
						/>
					</div>
				</div>
			</header>
			<section className="grid items-center gap-6 pt-6 pb-8 md:py-10">
				<div className="flex flex-col items-center gap-16">
					{
						(selectedPlaforms.length == 0 ? platforms : selectedPlaforms).map(({ value: platform }) => {
							return (selectedShapes.length == 0 ? shapes : selectedShapes).map(({ value: shape, limits }) => {
								return (selectedColors.length == 0 ? colors : selectedColors).map(({ value: color }) => {
									return (selectedBackgrounds.length == 0 ? backgrounds : selectedBackgrounds).map(({ value: background }) => {
										if(isLimited(limits, background, color)) {
											return null
										}
										else {
											return (
												<PreviewAppIcon
													platform={platform}
													background={background}
													color={color}
													shape={shape}
												/>
											)
										}
									})
								})
							})
						})
					}
				</div>
			</section>
		</Layout>
	)
}
