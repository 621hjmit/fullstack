/*// 필터 데이터를 불러오는 함수
document.addEventListener("DOMContentLoaded", function() {
    // URL에서 detailCategoryId 파라미터 추출
    const urlParams = new URLSearchParams(window.location.search);
    const detailCategoryId = urlParams.get('detailCategoryId');
    if (detailCategoryId) {
        loadFilterData(detailCategoryId);
    }

    // 필터 항목 클릭 이벤트 바인딩
    const colorFilterContainer = document.getElementById('color-filter');
    if (colorFilterContainer) {
        colorFilterContainer.addEventListener('change', function(e) {
            if (e.target && e.target.matches('.custom-input[type="checkbox"]')) {
                filterProductsByColor();
            }
        });
    }
});

// 필터 데이터를 불러오는 함수
function loadFilterData(detailCategoryId) {
    // 색상 필터 데이터를 불러오기
    axios.get(`/productColors/filterItemCount?detailCategoryId=${detailCategoryId}`)
        .then(response => {
            const colors = response.data;
            const colorFilterContainer = document.getElementById('color-filter');

            // 기존 내용 삭제
            if (colorFilterContainer) {
                colorFilterContainer.innerHTML = '';

                // 모든 색상 옵션을 불러오기 위해 추가로 요청
                axios.get('/productColors')
                    .then(allColorsResponse => {
                        const allColors = allColorsResponse.data;

                        allColors.forEach(color => {
                            const matchingColor = colors.find(c => c.pcId === color.pcId);
                            const itemCount = matchingColor ? matchingColor.itemCount : 0;

                            const colorItem = `
                                <li class="inputwrapper">
                                    <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                        name="dropdown-colorWithNames" id="dropdown-colorWithNames-${color.pcName}" value="${color.pcName}">
                                    <label class="label" for="dropdown-colorWithNames-${color.pcName}">
                                        <span class="item-color" style="background:${color.pcCode};"></span>
                                        <span class="text">${color.pcName}</span>
                                        <span class="item-count">${itemCount}</span>
                                    </label>
                                </li>`;
                            colorFilterContainer.insertAdjacentHTML('beforeend', colorItem);
                        });
                    })
                    .catch(error => {
                        console.error('모든 색상 데이터를 불러오는 중 오류 발생:', error);
                    });
            }
        })
        .catch(error => {
            console.error('필터 데이터를 불러오는 중 오류 발생:', error);
        });

	// 소재 필터 데이터를 불러오기
	axios.get('/productMaterials')
		.then(response => {
			const materials = response.data;
			const materialFilterContainer = document.getElementById('material-filter');

			// 기존 내용 삭제
			materialFilterContainer.innerHTML = '';

			// 새 필터 항목 추가
			materials.forEach(material => {
				const materialItem = `
                    <li class="inputwrapper">
                        <input class="custom-input" type="checkbox" data-name="materials"
                            name="dropdown-materials" id="dropdown-materials-${material.pmName}" value="${material.pmName}">
                        <label class="label" for="dropdown-materials-${material.pmName}">
                            <span class="text">${material.pmName}</span>
                            <span class="item-count">0</span>
                        </label>
                    </li>`;
				materialFilterContainer.insertAdjacentHTML('beforeend', materialItem);
			});
		})
		.catch(error => {
			console.error('필터 데이터를 불러오는 중 오류 발생:', error);
		});

	// 사이즈 필터 데이터를 불러오기
	axios.get('/productSizes')
		.then(response => {
			const sizes = response.data;
			const sizeFilterContainer = document.getElementById('size-filter');

			// 기존 내용 삭제
			sizeFilterContainer.innerHTML = '';

			// 새 필터 항목 추가
			sizes.forEach(size => {
				const sizeItem = `
					<li class="inputwrapper">
					<input class="custom-input" type="button" data-name="size" name="dropdown-size" id="dropdown-size-${size.psName}" value="${size.psName}">
					</li>`;
				sizeFilterContainer.insertAdjacentHTML('beforeend', sizeItem);
			});
		})
		.catch(error => {
			console.error('필터 데이터를 불러오는 중 오류 발생:', error);
		});

}

// 색상 필터링 로직 함수
function filterProductsByColor() {
    const checkedColors = Array.from(document.querySelectorAll('#color-filter .custom-input:checked'))
        .map(input => input.value);

    // 필터링할 데이터를 새로 구성
    $filterData = $allData.filter(product => {
        return product.productImgs.some(img => checkedColors.includes(img.colorName));
    });

    // 제품 목록을 갱신
    $container.empty();
    $added = 0;
    index = 0;
    addItem(true);
}
*/