import styles from "./preview-app-icon.module.css";

function Icons({ src, color, overlay }: { src: string, color: string, overlay: boolean }) {
	return (
		<div className={`${styles[`bg${color}`]} ${overlay ? styles[`withOverlay${color}`] : ''}`}>
			<div className="flex flex-row items-end gap-8 p-8 relative">
				<img
					src={src}
					width="32"
					/>
				<img
					src={src}
					width="64"
					/>
				<img
					src={src}
					width="128"
					/>
				{/* { overlay && <div className={`${styles[`overlay${color}`]} absolute left-0 top-0 w-full h-full`}></div> } */}
			</div>
		</div>
	)
}

export function PreviewAppIcon({ id, src }) {
	return (
		<div id={id} className="grid grid-cols-3 gap-0">
			<Icons src={src} color={'White'} overlay={false}/>
			<Icons src={src} color={'Grey'} overlay={false}/>
			<Icons src={src} color={'Green'} overlay={false}/>
			<Icons src={src} color={'White'} overlay={true}/>
			<Icons src={src} color={'Grey'} overlay={true}/>
			<Icons src={src} color={'Green'} overlay={true}/>
		</div>
	)
}
