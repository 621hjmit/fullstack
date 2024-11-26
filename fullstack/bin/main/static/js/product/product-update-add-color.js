// 전역 변수 선언
let loadedProductData;

document.addEventListener("DOMContentLoaded", async function() {
	await loadProductData();

	// '새로운 제품으로 등록' 버튼 클릭 이벤트 추가
	const duplicateProductButton = document.getElementById("duplicateProductButton");
	if (duplicateProductButton) {
		duplicateProductButton.addEventListener("click", duplicateProduct);
	}

	// '제품 이미지 수정' 버튼 클릭 이벤트 추가
	const updateProductImagesButton = document.getElementById("updateProductImagesButton");
	if (updateProductImagesButton) {
		updateProductImagesButton.addEventListener("click", updateProductImages);
	}

	// '제품 수정' 버튼 클릭 이벤트 추가
	const updateProductButton = document.getElementById("updateProductButton");
	if (updateProductButton) {
		updateProductButton.addEventListener("click", updateProduct);
	}
});

function getProductIdFromUrl() {
	const urlParams = new URLSearchParams(window.location.search);
	const piId = urlParams.get('piId');
	if (!piId) {
		throw new Error("URL에서 piId를 찾을 수 없습니다.");
	}
	return piId;
}

// 메인 이미지 미리보기 (기존 이미지 로드 포함)
function previewMainImage(imageUrl = null) {
	const mainImagePreviewContainer = document.querySelector('#mainImagePreviewContainer');
	mainImagePreviewContainer.innerHTML = ""; // 기존 미리보기 초기화

	if (imageUrl) {
		const img = document.createElement("img");
		img.classList.add("img-thumbnail", "me-2", "mb-2");
		img.style.width = "100px";
		img.style.height = "100px";
		img.src = `/uploads/product/images/${imageUrl}`;
		mainImagePreviewContainer.appendChild(img);
	}

	const mainImageFile = document.querySelector('#mainImageUpload').files[0];
	if (mainImageFile && mainImageFile.type.startsWith('image/')) {
		const img = document.createElement("img");
		img.classList.add("img-thumbnail", "me-2", "mb-2");
		img.style.width = "100px";
		img.style.height = "100px";
		mainImagePreviewContainer.appendChild(img);

		const reader = new FileReader();
		reader.onload = (e) => { img.src = e.target.result; };
		reader.readAsDataURL(mainImageFile);
	}
}

// 세부 이미지 미리보기 (기존 이미지 로드 포함)
function previewDetailImages(imageUrls = []) {
	const detailImagePreviewContainer = document.querySelector('#detailImagePreviewContainer');
	detailImagePreviewContainer.innerHTML = ""; // 기존 미리보기 초기화

	imageUrls.forEach(url => {
		const img = document.createElement("img");
		img.classList.add("img-thumbnail", "me-2", "mb-2");
		img.style.width = "100px";
		img.style.height = "100px";
		img.src = `/uploads/product/images/${url}`;
		detailImagePreviewContainer.appendChild(img);
	});

	const detailImageFiles = document.querySelector('#detailImageUpload').files;
	for (let i = 0; i < detailImageFiles.length; i++) {
		const file = detailImageFiles[i];
		if (file.type.startsWith('image/')) {
			const img = document.createElement("img");
			img.classList.add("img-thumbnail", "me-2", "mb-2");
			img.style.width = "100px";
			img.style.height = "100px";
			detailImagePreviewContainer.appendChild(img);

			const reader = new FileReader();
			reader.onload = (e) => { img.src = e.target.result; };
			reader.readAsDataURL(file);
		}
	}
}

// 새 창을 통해 색상, 소재, 사이즈 선택
function openColorSelection() {
	const width = 600, height = 800;
	const left = (window.screen.width / 2) - (width / 2);
	const top = (window.screen.height / 2) - (height / 2);
	window.open("product-insert-color", "색상 선택", `width=${width},height=${height},top=${top},left=${left}`);
}

// 선택된 색상을 부모 창의 색상 필드에 추가
function updateColors(selectedColors) {
	const colorInputContainer = document.querySelector("#colorInputContainer");
	colorInputContainer.innerHTML = ""; // 기존의 input 필드를 모두 지웁니다.

	selectedColors.forEach(color => {
		// 전달된 color 객체의 속성 값을 로그로 출력하여 확인
		console.log("Color 객체:", color);
		console.log("Color ID:", color.id, "Color Name:", color.name);

		// 컬러 ID를 저장하는 hidden input 생성
		const newInput = document.createElement("input");
		newInput.type = "hidden";
		newInput.value = color.id;  // 컬러 ID 저장
		newInput.className = "color-id-input";
		colorInputContainer.appendChild(newInput);

		// 컬러 이름을 표시하는 text input 생성
		const colorNameInput = document.createElement("input");
		colorNameInput.type = "text";
		colorNameInput.value = color.name;  // 컬러 이름만 표시
		colorNameInput.className = "form-control mb-2";
		colorNameInput.readOnly = true;
		colorInputContainer.appendChild(colorNameInput);
	});
}


// 제품 데이터 로드 함수
async function loadProductData() {
	try {
		const piId = getProductIdFromUrl();
		console.log('Loading product with ID:', piId);
		if (!piId) {
			throw new Error("piId가 유효하지 않습니다.");
		}

		const productResponse = await axios.get(`/product/${piId}`);
		const product = productResponse.data;

		// 로드된 데이터를 전역 변수에 저장
		loadedProductData = product;

		// 메인 카테고리 정보 로드
		let mainCategoryName = "N/A";
		let subCategoryName = "N/A";
		let detailCategoryName = "N/A";

		if (product.piMainCategoryId) {
			const mainCategoryResponse = await axios.get(`/mainCategories/${product.piMainCategoryId}`);
			mainCategoryName = mainCategoryResponse.data.mainCategoryName || "N/A";
			document.querySelector("#mainCategoryInput").setAttribute('data-category-id', product.piMainCategoryId);
		}

		if (product.piSubCategoryId) {
			const subCategoryResponse = await axios.get(`/subCategories/${product.piSubCategoryId}`);
			subCategoryName = subCategoryResponse.data.subCategoryName || "N/A";
			document.querySelector("#subCategoryInput").setAttribute('data-category-id', product.piSubCategoryId);
		}

		if (product.piDetailCategoryId) {
			const detailCategoryResponse = await axios.get(`/detailCategories/${product.piDetailCategoryId}`);
			detailCategoryName = detailCategoryResponse.data.detailCategoryName || "N/A";
			document.querySelector("#detailCategoryInput").setAttribute('data-category-id', product.piDetailCategoryId);
		}

		// 카테고리 정보를 읽기 전용 인풋 필드에 설정
		document.querySelector("#mainCategoryInput").value = mainCategoryName;
		document.querySelector("#subCategoryInput").value = subCategoryName;
		document.querySelector("#detailCategoryInput").value = detailCategoryName;

		// 상품명, 가격, 소재 읽기 전용 설정
		document.querySelector("#piName").value = product.piName;
		document.querySelector("#piPrice").value = product.piPrice;
		document.querySelector("#piMaterialTitle").value = product.piMaterialTitle;

		// 소재 카테고리 읽기 전용 설정
		const selectedMaterialField = document.querySelector("#selectedMaterial");
		if (product.materialList && product.materialList.length > 0) {
			selectedMaterialField.value = product.materialList[0].pmName;
			selectedMaterialField.setAttribute('data-material-id', product.materialList[0].pmId);
			selectedMaterialField.readOnly = true;
		} else {
			selectedMaterialField.value = "";
			selectedMaterialField.readOnly = true;
		}

		// 사이즈 목록 읽기 전용 설정
		const sizeInputContainer = document.querySelector("#sizeInputContainer");
		sizeInputContainer.innerHTML = ""; // 기존 내용을 초기화합니다.
		if (product.sizeList && product.sizeList.length > 0) {
			product.sizeList.forEach(size => {
				const sizeInput = document.createElement("input");
				sizeInput.type = "text";
				sizeInput.value = size.psName;
				sizeInput.dataset.sizeId = size.psId;
				sizeInput.className = "form-control mb-2";
				sizeInput.readOnly = true; // 읽기 전용 설정
				sizeInputContainer.appendChild(sizeInput);
			});
		}

		// 주요 정보 목록 (읽기 전용 설정)
		const inputContainer = document.querySelector("#inputContainer");
		inputContainer.innerHTML = ""; // 기존 내용을 초기화합니다.
		if (product.mainInfoList && product.mainInfoList.length > 0) {
			product.mainInfoList.forEach(mainInfo => {
				const mainInfoInput = document.createElement("input");
				mainInfoInput.type = "text";
				mainInfoInput.value = mainInfo.pmiDesc;
				mainInfoInput.className = "form-control mb-2";
				mainInfoInput.readOnly = true; // 읽기 전용 설정
				inputContainer.appendChild(mainInfoInput);
			});
		}

		// 제품명, 가격, 소재 필드를 읽기 전용으로 설정
		document.querySelector("#piName").readOnly = true;
		document.querySelector("#piPrice").readOnly = true;
		document.querySelector("#piMaterialTitle").readOnly = true;

		// 제조국과 스토리는 기존 데이터 불러옴
		document.querySelector("#piCountryOfOrigin").value = product.piCountryOfOrigin;
		document.querySelector("#piStory").value = product.piStory;

	} catch (error) {
		console.error("제품 정보 불러오기 오류:", error);
		alert("제품 정보를 불러오는 중 오류가 발생했습니다.");
	}
}

// 새로운 제품으로 등록하는 함수
async function duplicateProduct() {
	try {
		// 제품 정보 수집
		const piCode = document.querySelector("#piCode").value;
		const piName = document.querySelector("#piName").value;
		const piPrice = document.querySelector("#piPrice").value;
		const piCountryOfOrigin = document.querySelector("#piCountryOfOrigin").value;
		const piMainCategoryId = parseInt(document.querySelector("#mainCategoryInput").getAttribute('data-category-id'));
		const piSubCategoryId = parseInt(document.querySelector("#subCategoryInput").getAttribute('data-category-id'));
		const piDetailCategoryId = parseInt(document.querySelector("#detailCategoryInput").getAttribute('data-category-id'));
		const piStory = document.querySelector("#piStory").value;
		const piColorTitle = document.querySelector("#piColorTitle").value;
		const piMaterialTitle = document.querySelector("#piMaterialTitle").value;

		if (!piName || isNaN(piMainCategoryId) || isNaN(piSubCategoryId) || isNaN(piDetailCategoryId) || !piPrice) {
			throw new Error("필수 제품 정보가 누락되었습니다. 모든 필드를 확인해주세요.");
		}

		// 제품 데이터 준비
		const productData = {
			piCode,
			piName,
			piPrice,
			piCountryOfOrigin,
			piMainCategoryId,
			piSubCategoryId,
			piDetailCategoryId,
			piStory,
			piColorTitle,
			piMaterialTitle,
			colorList: Array.from(document.querySelectorAll("#colorInputContainer .color-id-input")).map(input => ({
				pcId: parseInt(input.value)
			})).filter(color => !isNaN(color.pcId)),
			sizeList: Array.from(document.querySelectorAll("#sizeInputContainer input")).map(input => ({
				psId: parseInt(input.dataset.sizeId)
			})).filter(size => !isNaN(size.psId)),
			materialList: loadedProductData.materialList ? loadedProductData.materialList : [],
			mainInfoList: Array.from(document.querySelectorAll("#inputContainer input")).map(input => ({
				pmiDesc: input.value
			})).filter(mainInfo => mainInfo.pmiDesc !== ""),
			productDetailInfo: {
				pdiHeight: parseInt(document.querySelector("#pdiHeight").value),
				pdiSize: parseInt(document.querySelector("#pdiSize").value)
			}
		};

		// FormData 생성 및 이미지 파일 추가
		const mainImageFile = document.querySelector("#mainImageUpload").files[0];
		const detailImageFiles = document.querySelector("#detailImageUpload").files;
		const formData = new FormData();
		formData.append("productData", new Blob([JSON.stringify(productData)], { type: "application/json" }));

		// 메인 이미지 추가
		if (mainImageFile) {
			formData.append("images", mainImageFile);
		}

		for (let i = 0; i < detailImageFiles.length; i++) {
			formData.append("images", detailImageFiles[i]);
		}

		// 제품 정보 서버에 저장 (ProductController 호출)
		const productResponse = await axios.post('/product', formData, {
			headers: { 'Content-Type': 'multipart/form-data' }
		});

		if (productResponse.status !== 200) {
			alert('상품 등록 중 오류가 발생했습니다. 다시 시도해주세요.');
			return;
		}

		// 등록된 새 제품의 ID 가져오기
		const newProductId = productResponse.data.piId;

		// 기존 제품 ID 가져오기
		const originalProductId = getProductIdFromUrl();

		console.log("originalProductId:", originalProductId);
		console.log("newProductId:", newProductId);

		// 두 제품 간의 색상 매핑 테이블에 추가
		let linkResponse;
		try {
			linkResponse = await axios.post('/colorProductLink', null, {
				params: {
					originalProductId: originalProductId,
					newProductId: newProductId
				}
			});

			if (linkResponse.status !== 200) {
				throw new Error("색상 매핑 추가 중 오류가 발생했습니다.");
			}
		} catch (linkError) {
			throw new Error("색상 매핑 추가 중 오류가 발생했습니다: " + linkError.message);
		}

		alert('상품이 성공적으로 등록되었습니다!');
		window.location.href = "/admin/product/product-list";
	} catch (error) {
		console.error('상품 등록 중 오류 발생:', error);
		alert('상품 등록 중 오류가 발생했습니다: ' + error.message);
	}
}

// 각 속성 정보를 연결 테이블에 저장하는 함수들
async function saveProductColor(productId, colorId) {
	try {
		await axios.post('/productColorMapping', {
			piId: productId,
			pcId: colorId
		});
		console.log(`제품 ID ${productId}에 색상 ID ${colorId}가 저장되었습니다.`);
	} catch (error) {
		console.error('색상 정보 저장 중 오류:', error);
	}
}

async function saveProductSize(productId, sizeId) {
	try {
		await axios.post('/productSizeMapping', {
			piId: productId,
			psId: sizeId
		});
		console.log(`제품 ID ${productId}에 사이즈 ID ${sizeId}가 저장되었습니다.`);
	} catch (error) {
		console.error('사이즈 정보 저장 중 오류:', error);
	}
}

async function saveProductMaterial(productId, materialId) {
	try {
		await axios.post('/productMaterialMapping', {
			piId: productId,
			pmId: materialId
		});
		console.log(`제품 ID ${productId}에 소재 ID ${materialId}가 저장되었습니다.`);
	} catch (error) {
		console.error('소재 정보 저장 중 오류:', error);
	}
}

async function saveProductMainInfo(productId, mainInfo) {
	try {
		await axios.post('/productMainInfo', {
			piId: productId,
			pmiDesc: mainInfo
		});
		console.log(`제품 ID ${productId}에 주요 정보가 저장되었습니다: ${mainInfo}`);
	} catch (error) {
		console.error('주요 정보 저장 중 오류:', error);
	}
}

// 기존 제품과의 색상 매핑을 처리하는 함수
async function linkColorProduct(originalProductId, newProductId) {
	try {
		const response = await axios.post('/colorProductLink', null, {
			params: {
				originalProductId,
				newProductId
			}
		});

		if (response.status !== 200) {
			throw new Error("색상 매핑 추가 중 오류가 발생했습니다.");
		}
	} catch (error) {
		console.error('색상 매핑 처리 중 오류 발생:', error);
		alert('색상 매핑 처리 중 오류가 발생했습니다.');
	}
}


// 페이지 로드 시 제품 데이터 로드
document.addEventListener('DOMContentLoaded', async function() {

	// '새로운 제품으로 등록' 버튼 클릭 이벤트 추가
	const duplicateProductButton = document.getElementById("duplicateProductButton");
	if (duplicateProductButton) {
		duplicateProductButton.addEventListener("click", duplicateProduct);
	}
});