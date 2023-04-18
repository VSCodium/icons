import styles from "./preview-app-icon.module.css";

const IS_PRODUCTION = process.env.IS_PRODUCTION

function Icons({ platform, background, color, shape, bgColor, overlay }: { platform: string, background: string, color: string, shape: string, bgColor: string, overlay: boolean }) {
	const src = IS_PRODUCTION ? `https://raw.githubusercontent.com/VSCodium/icons/main/icons/${platform}/${background}/${color}/${shape}.png` : `/icons/${platform}/${background}/${color}/${shape}.png`

	return (
		<div
			key={`preview_${platform}_${background}_${color}_${shape}_${bgColor}_${overlay}`}
			className={`${styles[`bg${bgColor}`]} ${overlay ? styles[`withOverlay${bgColor}`] : ''}`}
		>
			<div className="flex flex-row items-end gap-8 p-8 relative">
				<img
					src={src}
					alt="32px"
					width="32"
					height="32"
				/>
				<img
					src={src}
					alt="64px"
					width="64"
					height="64"
				/>
				<img
					src={src}
					alt="128px"
					width="128"
					height="128"
				/>
				{/* { overlay && <div className={`${styles[`overlay${color}`]} absolute left-0 top-0 w-full h-full`}></div> } */}
			</div>
		</div>
	)
}

export function PreviewAppIcon({ platform, background, color, shape }) {
	return (
		<div
			key={`preview_${platform}_${background}_${color}_${shape}`}
			className="flex flex-row items-center"
		>
			<div className="pr-4">
				Background: {background}<br />
				Color: {color}<br />
				Shape: {shape}
			</div>
			<div className="grid grid-cols-3 gap-0">
				{
					[false, true].map((overlay) => {
						return (
							<>
								<Icons
									platform={platform}
									background={background}
									color={color}
									shape={shape}
									bgColor={'White'}
									overlay={overlay}
								/>
								<Icons
									platform={platform}
									background={background}
									color={color}
									shape={shape}
									bgColor={'Grey'}
									overlay={overlay}
								/>
								<Icons
									platform={platform}
									background={background}
									color={color}
									shape={shape}
									bgColor={'Green'}
									overlay={overlay}
								/>
							</>
						)
					})
				}
			</div>
		</div>
	)
}
