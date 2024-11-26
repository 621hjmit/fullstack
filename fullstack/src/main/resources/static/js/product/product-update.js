let existingMainImage = null;
let existingDetailImages = [];

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
		// 기존 이미지를 불러와서 미리보기 추가
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

    // 기존 미리보기 초기화 (기존 DOM 요소 삭제)
    detailImagePreviewContainer.innerHTML = "";

    // 기존 이미지를 불러와서 미리보기 추가
    imageUrls.forEach(url => {
        const img = document.createElement("img");
        img.classList.add("img-thumbnail", "me-2", "mb-2");
        img.style.width = "100px";
        img.style.height = "100px";
        img.src = `/uploads/product/images/${url}`;
        detailImagePreviewContainer.appendChild(img);
    });

    // 새로 선택된 이미지 파일들도 미리보기에 추가
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

// 제품 데이터 로드 함수
async function loadProductData() {
    try {
        const piId = getProductIdFromUrl();
        console.log('Loading product with ID:', piId);
        if (!piId) {
            throw new Error("piId가 유효하지 않습니다.");
        }

        // 제품 정보 불러오기
        const productResponse = await axios.get(`/product/${piId}`);
        const product = productResponse.data;

        // 기존 이미지 URL 설정 (제품 정보가 로드된 후)
        let existingMainImage = product.productImgs && product.productImgs.length > 0 ? product.productImgs[0].pimgName : null; //요건 1번째 이미지가 메인이미지니까!!
        let existingDetailImages = product.productImgs && product.productImgs.length > 1 ? product.productImgs.slice(1).map(img => img.pimgName) : []; //세부 데이터 추출~~

        // 이미지 업데이트 함수 호출
        updateProductImages(existingMainImage, existingDetailImages);

        // 메인 카테고리 로드
        loadMainCategories(product.piMainCategoryId, product.piSubCategoryId, product.piDetailCategoryId);

        // 폼 데이터 채우기
        document.querySelector("#piCode").value = product.piCode;
        document.querySelector("#piName").value = product.piName;
        document.querySelector("#piPrice").value = product.piPrice;
        document.querySelector("#piCountryOfOrigin").value = product.piCountryOfOrigin;
        document.querySelector("#piStory").value = product.piStory;
        document.querySelector("#mainCategorySelect").value = product.piMainCategoryId;
        document.querySelector("#subCategorySelect").value = product.piSubCategoryId;
        document.querySelector("#detailCategorySelect").value = product.piDetailCategoryId;
        document.querySelector("#piColorTitle").value = product.piColorTitle;
        document.querySelector("#piMaterialTitle").value = product.piMaterialTitle;

        // 메인 이미지 로드
        if (product.productImgs && product.productImgs.length > 0) {
            existingMainImage = product.productImgs[0].pimgName; // 기존 메인 이미지 URL 저장
            previewMainImage(existingMainImage);
        }

        // 세부 이미지 로드
        if (product.productImgs && product.productImgs.length > 1) {
            existingDetailImages = product.productImgs.slice(1).map(img => img.pimgName); // 기존 세부 이미지 URL 저장
            previewDetailImages(existingDetailImages);
        }

        // 색상 목록
        const colorInputContainer = document.querySelector("#colorInputContainer");
        colorInputContainer.innerHTML = "";
        product.colorList.forEach(color => {
            const colorInput = document.createElement("input");
            colorInput.type = "hidden";
            colorInput.value = color.pcId;
            colorInput.className = "color-id-input";
            colorInputContainer.appendChild(colorInput);

            const colorNameInput = document.createElement("input");
            colorNameInput.type = "text";
            colorNameInput.value = color.pcName;
            colorNameInput.className = "form-control mb-2";
            colorNameInput.readOnly = true;
            colorInputContainer.appendChild(colorNameInput);
        });

        // 사이즈 목록
        const sizeInputContainer = document.querySelector("#sizeInputContainer");
        sizeInputContainer.innerHTML = "";
        product.sizeList.forEach(size => {
            const sizeInput = document.createElement("input");
            sizeInput.type = "text";
            sizeInput.value = size.psName;
            sizeInput.dataset.sizeId = size.psId;
            sizeInput.className = "form-control mb-2";
            sizeInput.readOnly = true;
            sizeInputContainer.appendChild(sizeInput);
        });

        // 소재 목록
        const selectedMaterialField = document.querySelector("#selectedMaterial");
        if (product.materialList.length > 0) {
            selectedMaterialField.value = product.materialList[0].pmName;
            selectedMaterialField.setAttribute('data-material-id', product.materialList[0].pmId);
        }

        // 주요 정보 목록
        const inputContainer = document.querySelector("#inputContainer");
        inputContainer.innerHTML = "";
        product.mainInfoList.forEach(mainInfo => {
            const mainInfoInput = document.createElement("input");
            mainInfoInput.type = "text";
            mainInfoInput.value = mainInfo.pmiDesc;
            mainInfoInput.className = "form-control mb-2";
            inputContainer.appendChild(mainInfoInput);
        });

        // 제품 세부 정보
        document.querySelector("#pdiHeight").value = product.productDetailInfo.pdiHeight;
        document.querySelector("#pdiSize").value = product.productDetailInfo.pdiSize;

    } catch (error) {
        console.error("제품 정보 불러오기 오류:", error);
        alert("제품 정보를 불러오는 중 오류가 발생했습니다.");
    }
}


// 입력 필드 추가
function addInputField() {
	const inputContainer = document.querySelector("#inputContainer");
	const inputCount = inputContainer.getElementsByTagName("input").length;

	if (inputCount < 10) {
		// 새로운 input 요소 생성
		const newInput = document.createElement("input");
		newInput.type = "text";
		newInput.className = "form-control mb-2"; // 스타일 지정
		inputContainer.appendChild(newInput);
	} else {
		alert("최대 10개까지만 추가할 수 있습니다.");
	}
}

// 새 창을 통해 색상, 소재, 사이즈 선택
function openColorSelection() {
	const width = 600, height = 800;
	const left = (window.screen.width / 2) - (width / 2);
	const top = (window.screen.height / 2) - (height / 2);
	window.open("product-insert-color", "색상 선택", `width=${width},height=${height},top=${top},left=${left}`);
}

function openMaterialSelection() {
	const width = 600, height = 800;
	const left = (window.screen.width / 2) - (width / 2);
	const top = (window.screen.height / 2) - (height / 2);
	window.open("product-insert-material", "소재 선택", `width=${width},height=${height},top=${top},left=${left}`);
}

function openSizeSelection() {
	const width = 600, height = 700;
	const left = (window.screen.width / 2) - (width / 2);
	const top = (window.screen.height / 2) - (height / 2);
	window.open("product-insert-size", "사이즈 선택", `width=${width},height=${height},top=${top},left=${left}`);
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

// 선택된 소재를 부모 창의 소재 필드에 추가
function updateMaterials(selectedMaterialId, selectedMaterialName) {
	const selectedMaterialField = document.querySelector("#selectedMaterial");
	selectedMaterialField.value = selectedMaterialName;
	selectedMaterialField.setAttribute('data-material-id', selectedMaterialId);
}

// 선택된 사이즈를 부모 창의 사이즈 필드에 추가
function updateSizes(selectedSizes) {
	const sizeInputContainer = document.querySelector("#sizeInputContainer");
	sizeInputContainer.innerHTML = ""; // 기존의 input 필드를 모두 지웁니다.

	selectedSizes.forEach(size => {
		const newInput = document.createElement("input");
		newInput.type = "text";
		newInput.value = size.name;  // 사이즈 이름
		newInput.dataset.sizeId = size.id;  // 사이즈 ID를 data-size-id 속성에 저장
		newInput.className = "form-control mb-2";
		newInput.readOnly = true;
		sizeInputContainer.appendChild(newInput);
	});
}

// 선택된 카테고리 업데이트
function updateSelectedCategory() {
	const mainCategorySelect = document.querySelector("#mainCategorySelect");
	const subCategorySelect = document.querySelector("#subCategorySelect");
	const detailCategorySelect = document.querySelector("#detailCategorySelect");

	// 모든 카테고리가 선택되었는지 확인
	if (!mainCategorySelect.value || !subCategorySelect.value || !detailCategorySelect.value) {
		alert("모든 카테고리를 선택해주세요.");
		return; // 카테고리가 모두 선택되지 않았으면 함수를 종료합니다.
	}

	const mainCategory = mainCategorySelect.selectedOptions[0].textContent;
	const subCategory = subCategorySelect.selectedOptions[0].textContent;
	const detailCategory = detailCategorySelect.selectedOptions[0].textContent;

	// 선택된 카테고리를 포맷팅
	const selectedCategory = [mainCategory, subCategory, detailCategory].join(" > ");
	document.querySelector("#selectedCategory").value = selectedCategory;
}

// 메인 카테고리 로드 및 기존 값 설정
function loadMainCategories(selectedMainCategoryId, selectedSubCategoryId, selectedDetailCategoryId) {
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/mainCategories", true);
	xhr.setRequestHeader("Content-Type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4 && xhr.status === 200) {
			var categories = JSON.parse(xhr.responseText);
			var mainCategorySelect = document.querySelector('#mainCategorySelect');
			mainCategorySelect.innerHTML = '<option value="">1차카테고리 선택</option>'; // 기존 옵션 초기화
			categories.forEach(function(category) {
				var option = document.createElement('option');
				option.value = category.mainCategoryId;
				option.text = category.mainCategoryName;
				if (category.mainCategoryId == selectedMainCategoryId) {
					option.selected = true;
				}
				mainCategorySelect.appendChild(option);
			});

			// 선택된 메인 카테고리에 따른 서브 카테고리 로드
			loadSubCategories(selectedSubCategoryId, selectedDetailCategoryId);
		} else if (xhr.readyState === 4) {
			console.error("메인 카테고리 불러오기 중 오류:", xhr.status);
		}
	};
	xhr.send();
}

// 선택된 메인 카테고리에 따른 서브 카테고리 로드 함수
function loadSubCategories(selectedSubCategoryId, selectedDetailCategoryId) {
	var mainCategoryId = document.querySelector('#mainCategorySelect').value;

	if (!mainCategoryId) {
		document.querySelector('#subCategorySelect').innerHTML = '<option value="">카테고리를 선택해주세요</option>';
		return;
	}

	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/mainSubCategories?mainCategoryId=" + mainCategoryId, true);
	xhr.setRequestHeader("Content-Type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				var subCategories = JSON.parse(xhr.responseText);
				var subCategorySelect = document.querySelector('#subCategorySelect');
				subCategorySelect.innerHTML = '<option value="">2차카테고리 선택</option>'; // 기존 옵션 초기화

				subCategories.forEach(function(subCategory) {
					var option = document.createElement('option');
					option.value = subCategory.subCategoryId;
					option.text = subCategory.subCategoryName;
					if (subCategory.subCategoryId == selectedSubCategoryId) {
						option.selected = true;
					}
					subCategorySelect.appendChild(option);
				});

				// 서브 카테고리 로드 후 세부 카테고리 셀렉트 초기화 및 값 설정
				loadDetailCategories(selectedDetailCategoryId);
			} else {
				console.error("서브 카테고리 불러오기 중 오류:", xhr.status, xhr.responseText);
				alert("서브 카테고리 불러오기 오류. 관리자에게 문의하세요.");
			}
		}
	};

	xhr.send();
}

// 선택된 서브 카테고리에 따른 세부 카테고리 로드 함수
function loadDetailCategories(selectedDetailCategoryId) {
	var subCategoryId = document.querySelector('#subCategorySelect').value;

	if (!subCategoryId) {
		document.querySelector('#detailCategorySelect').innerHTML = '<option value="">서브 카테고리를 선택해주세요</option>';
		return;
	}

	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/subDetailCategories?subCategoryId=" + subCategoryId, true);
	xhr.setRequestHeader("Content-Type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				var detailCategories = JSON.parse(xhr.responseText);
				var detailCategorySelect = document.querySelector('#detailCategorySelect');
				detailCategorySelect.innerHTML = '<option value="">3차카테고리 선택</option>'; // 기존 옵션 초기화

				detailCategories.forEach(function(detailCategory) {
					var option = document.createElement('option');
					option.value = detailCategory.detailCategoryId;
					option.text = detailCategory.detailCategoryName;
					if (detailCategory.detailCategoryId == selectedDetailCategoryId) {
						option.selected = true;
					}
					detailCategorySelect.appendChild(option);
				});
			} else {
				console.error("세부 카테고리 불러오기 중 오류:", xhr.status, xhr.responseText);
				alert("세부 카테고리 불러오기 오류. 관리자에게 문의하세요.");
			}
		}
	};

	xhr.send();
}

// 카테고리 변경 시 호출되는 함수들
document.querySelector('#mainCategorySelect').addEventListener('change', function() {
	loadSubCategories();
});

document.querySelector('#subCategorySelect').addEventListener('change', function() {
	loadDetailCategories();
});

// 제품 이미지 수정 함수
// 제품 이미지 수정 함수
async function updateProductImages(existingMainImage, existingDetailImages) {
    try {
        const piId = getProductIdFromUrl();
        const mainImageInput = document.getElementById("mainImageUpload");
        const mainImageFile = mainImageInput.files[0];
        const detailImageInput = document.getElementById("detailImageUpload");
        const detailImageFiles = detailImageInput.files;

        const formData = new FormData();

        // 메인 이미지 파일이 선택되지 않았으면 기존 이미지 URL을 전송
        if (mainImageFile) {
            formData.append("mainImage", mainImageFile);  // 새 메인 이미지
        } else if (existingMainImage) {
            formData.append("existingMainImageUrl", existingMainImage);  // 기존 메인 이미지
        }

        // 세부 이미지 처리 로직 수정
        if (detailImageFiles.length > 0) {
            // 새로운 세부 이미지가 있다면 기존 세부 이미지를 보내지 않음
            for (let i = 0; i < detailImageFiles.length; i++) {
                formData.append("detailImages", detailImageFiles[i]);
            }
        } else if (existingDetailImages && existingDetailImages.length > 0) {
            // 새로운 세부 이미지가 없을 때만 기존 이미지를 보냄
            existingDetailImages.forEach((url) => {
                formData.append("existingDetailImagesUrls", url);  // 기존 세부 이미지 URL들
            });
        }

        const response = await axios.put(`/productImg/${piId}/update`, formData, {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        });

        if (response.status !== 200) {
            throw new Error("이미지 업데이트 중 오류 발생");
        }
        console.log("이미지 업데이트 완료!");
    } catch (error) {
        console.error("이미지 수정 중 오류 발생:", error);
        alert("이미지 수정 중 오류가 발생했습니다. 다시 시도해주세요.");
    }
}


// 제품 수정 함수
async function updateProduct() {
	try {
		const piId = getProductIdFromUrl();

		const productData = {
			piId: piId,
			piCode: document.querySelector("#piCode").value,
			piName: document.querySelector("#piName").value,
			piPrice: document.querySelector("#piPrice").value,
			piCountryOfOrigin: document.querySelector("#piCountryOfOrigin").value,
			piMainCategoryId: parseInt(document.querySelector("#mainCategorySelect").value),
			piSubCategoryId: parseInt(document.querySelector("#subCategorySelect").value),
			piDetailCategoryId: parseInt(document.querySelector("#detailCategorySelect").value),
			piStory: document.querySelector("#piStory").value,
			piColorTitle: document.querySelector("#piColorTitle").value,
			piMaterialTitle: document.querySelector("#piMaterialTitle").value
		};

		const colorData = Array.from(document.querySelectorAll("#colorInputContainer .color-id-input")).map(input => ({
			pcId: parseInt(input.value)
		}));

		const sizeData = Array.from(document.querySelectorAll("#sizeInputContainer input")).map(input => ({
			psId: parseInt(input.dataset.sizeId)
		}));

		const mainInfoData = Array.from(document.querySelectorAll("#inputContainer input")).map(input => ({
			pmiDesc: input.value
		}));

		const updateRequests = [
			axios.put(`/product/${piId}`, productData),
			axios.put(`/productColorMapping/${piId}`, colorData),
			axios.put(`/productSizeMapping/${piId}`, sizeData),
			axios.put(`/productMaterialMapping/${piId}`, {
				piId: piId,
				pmId: parseInt(document.querySelector("#selectedMaterial").getAttribute('data-material-id'))
			}),
			axios.put(`/productMainInfo/${piId}`, mainInfoData),
			axios.put(`/productDetailInfo/${piId}`, {
				piId: piId,
				pdiHeight: parseInt(document.querySelector("#pdiHeight").value),
				pdiSize: document.querySelector("#pdiSize").value
			})
		];

		const responses = await Promise.all(updateRequests);

		if (responses.some(response => response.status !== 200)) {
			throw new Error("일부 업데이트 요청이 실패했습니다.");
		}

		await updateProductImages();

		alert('제품이 성공적으로 업데이트되었습니다!');
		window.location.href = "/admin/product/product-list";
	} catch (error) {
		console.error('제품 업데이트 중 오류 발생:', error);
		alert('제품 업데이트 중 오류가 발생했습니다. 다시 시도해주세요.');
	}
}

// 페이지 로드 시 제품 데이터 불러오기
document.addEventListener("DOMContentLoaded", loadProductData);





