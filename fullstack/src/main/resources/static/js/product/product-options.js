window.addEventListener("load", function () {
    const selectConditionElement = document.getElementById("selectCondition");
    const saveButtonElement = document.getElementById("saveButton");
    const listContainer = document.getElementById("listContainer");
    const keywordElement = document.getElementById("keyword");

    // 선택 조건 변경 이벤트 설정
    if (selectConditionElement) {
        selectConditionElement.addEventListener("change", async function () {
            const selectedValue = this.value;

            if (selectedValue && selectedValue !== "") {
                if (selectedValue === "1") {
                    // 단일 데이터 처리
                    keywordElement.style.display = "block";
                    listContainer.style.display = "none";
                    await fetchAndDisplaySingleInfo('/productAddInfo', 'paiDesc', 1); // 예시 ID 사용
                } else {
                    // 리스트 데이터 처리
                    let url, descriptionKey;
                    keywordElement.style.display = "none";
                    listContainer.style.display = "block";
                    if (selectedValue === "2") {
                        url = '/productDeliveries';
                        descriptionKey = 'pdDesc';
                    } else if (selectedValue === "3") {
                        url = '/productPayments';
                        descriptionKey = 'ppDesc';
                    } else if (selectedValue === "4") {
                        url = '/productRefunds';
                        descriptionKey = 'prDesc';
                    } else if (selectedValue === "5") {
                        url = '/productGifts';
                        descriptionKey = 'pgText';
                    }
                    if (url && descriptionKey) {
                        await fetchAndDisplayListInfo(url, descriptionKey);
                    }
                }
            } else {
                keywordElement.value = '';
                listContainer.innerHTML = '';
            }
        });
    } else {
        console.error("Select condition element not found.");
    }

	// 저장 버튼 클릭 이벤트 설정
	if (saveButtonElement) {
	    saveButtonElement.addEventListener("click", async function () {
	        const selectedValue = document.getElementById("selectCondition").value;

	        if (selectedValue === "1") {
	            // 단일 데이터 업데이트 (PUT 요청 사용)
	            const updatedContent = keywordElement.value.trim(); // 공백 제거
	            const data = {
	                paiId: 1, // 이 ID는 예시이며, 실제 사용 시 올바른 ID로 교체해야 함
	                paiDesc: updatedContent
	            };

	            // 데이터 확인
	            console.log('전송할 추가정보 데이터:', JSON.stringify(data));

	            await postOrPutInfo('/productAddInfo', data, 'PUT');
	        } else {
	            // 나머지 리스트 데이터 업데이트 (한번에 PUT 요청 사용)
	            const items = Array.from(listContainer.querySelectorAll('input'));
	            let updatedContentArray = [];

	            items.forEach((input) => {
	                const originalValue = input.dataset.originalValue || '';
	                const currentValue = input.value.trim();
	                const itemId = input.dataset.id;

	                // 원래 값과 현재 값이 다르다면 배열에 추가
	                if (itemId && itemId !== 'undefined' && originalValue.trim() !== currentValue) {
	                    if (selectedValue === "2") {
	                        updatedContentArray.push({
	                            pdId: parseInt(itemId),
	                            pdDesc: currentValue,
	                        });
	                    } else if (selectedValue === "3") {
	                        updatedContentArray.push({
	                            ppId: parseInt(itemId),
	                            ppDesc: currentValue,
	                        });
	                    } else if (selectedValue === "4") {
	                        updatedContentArray.push({
	                            prId: parseInt(itemId),
	                            prDesc: currentValue,
	                        });
	                    } else if (selectedValue === "5") {
	                        updatedContentArray.push({
	                            pgId: parseInt(itemId),
	                            pgText: currentValue,
	                        });
	                    }
	                }
	            });

	            if (updatedContentArray.length === 0) {
	                alert('수정된 항목이 없습니다.');
	                return;
	            }

	            let url;
	            if (selectedValue === "2") {
	                url = '/productDeliveries';
	            } else if (selectedValue === "3") {
	                url = '/productPayments';
	            } else if (selectedValue === "4") {
	                url = '/productRefunds';
	            } else if (selectedValue === "5") {
	                url = '/productGifts';
	            }

	            console.log('수정할 URL:', url);
	            console.log('전송할 데이터:', JSON.stringify(updatedContentArray));

	            await postOrPutInfo(url, updatedContentArray, 'PUT');
	        }
	    });
	} else {
	    console.error("Save button element not found.");
	}
});

// 서버에서 단일 데이터를 가져와 입력 필드에 표시하는 함수
async function fetchAndDisplaySingleInfo(url, descriptionKey, paiId) {
    try {
        // keywordElement를 함수 내에서 다시 가져오기
        const keywordElement = document.getElementById("keyword");

        if (!keywordElement) {
            console.error("Keyword element not found.");
            return;
        }

        const response = await fetch(`${url}?paiId=${paiId}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
        });

        if (!response.ok) {
            throw new Error('추가 정보를 가져오는 데 실패했습니다.');
        }

        const data = await response.json();
        console.log('API 응답 데이터:', data);

        if (Array.isArray(data) && data.length > 0) {
            const validItem = data.find(item => item[descriptionKey] !== null);
            if (validItem && validItem[descriptionKey]) {
                keywordElement.value = validItem[descriptionKey];
            } else {
                keywordElement.value = '';
            }
        } else {
            keywordElement.value = '';
        }
    } catch (error) {
        console.error('추가 정보 가져오기 중 오류:', error);
        alert('선택된 추가 정보를 가져오는 중 오류가 발생했습니다.');
    }
}

// 서버에서 리스트 데이터를 가져와 개별 입력 필드로 표시하는 함수
async function fetchAndDisplayListInfo(url, descriptionKey) {
    try {
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
        });

        if (!response.ok) {
            throw new Error('추가 정보를 가져오는 데 실패했습니다.');
        }

        const data = await response.json();
        console.log('API 응답 데이터:', data);

        listContainer.innerHTML = '';
        if (data && data.length > 0) {
            data.forEach((item) => {
                addListItem(item[descriptionKey] || '', item.pdId || item.ppId || item.prId || item.pgId);
            });
        }
    } catch (error) {
        console.error('추가 정보 가져오기 중 오류:', error);
        alert('선택된 추가 정보를 가져오는 중 오류가 발생했습니다.');
    }
}

// 리스트 항목을 추가하는 함수
function addListItem(value, id) {
    const listItem = document.createElement('div');
    listItem.className = 'mb-2';
    const input = document.createElement('input');
    input.type = 'text';
    input.className = 'form-control';
    input.value = value;
    input.dataset.originalValue = value.trim();  // 원래 값 저장, 공백 제거
    input.dataset.id = id;  // 아이디 저장

    listItem.appendChild(input);
    listContainer.appendChild(listItem);
}

// 서버에 단일 데이터를 POST 또는 PUT 요청으로 전송하는 함수
async function postOrPutSingleInfo(url, data, method) {
    try {
        const response = await fetch(url, {
            method: method,
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        });

        if (!response.ok) {
            throw new Error('데이터를 저장하는 데 실패했습니다.');
        }

        console.log('수정된 데이터:', data); // 수정된 데이터를 콘솔에 로그로 출력
        alert('데이터가 성공적으로 저장되었습니다!');
    } catch (error) {
        console.error('데이터 저장 중 오류:', error);
        alert('데이터를 저장하는 중 오류가 발생했습니다.');
    }
}

// 서버에 단일 데이터를 POST 또는 PUT 요청으로 전송하는 함수
async function postOrPutInfo(url, data, method) {
    try {
        // 요청 보내기 전에 데이터가 올바른지 확인 (직렬화된 데이터)
        console.log('전송할 데이터:', JSON.stringify(data));

        const response = await fetch(url, {
            method: method,
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        });

        if (!response.ok) {
            throw new Error('데이터를 저장하는 데 실패했습니다.');
        }

        console.log('수정된 데이터:', data); // 수정된 데이터를 콘솔에 로그로 출력
        alert('데이터가 성공적으로 저장되었습니다!');
    } catch (error) {
        console.error('데이터 저장 중 오류:', error);
        alert('데이터를 저장하는 중 오류가 발생했습니다.');
    }
}