window.addEventListener('load', () => init());

let flag = "order";
let grid;
const today = new Date().toLocaleDateString('ko-KR', {
	year: 'numeric',
	month: '2-digit',
	day: '2-digit'
}).replace(/\. /g, '-').replace('.', '');
let endDate = today;
let startDate2 = today;

let pageCount = 10;
let page = 1;

let orId;
let uiNum;
let uiName;
let payName;
let deiReceiver;
let piName;
let orStatusPay;
let orStatusDelivery;
let orCancle;
let orExchange;
let orReturn;
let orRefund;
let oiStatusPay;
let oiStatusDelivery;
let oiCancle;
let oiExchange;
let oiReturn;
let oiRefund;

function init(){
	setPage();
	uiNum = getQueryParam('uiNum');
	showOrders();
}
function setPage(){
  let str = document.querySelector(".page-header-title>h2").textContent;
  document.title = str + " | Hermes Admin";
}
function getQueryParam(param) {
	const urlParams = new URLSearchParams(window.location.search);
	return urlParams.get(param);
}
// 주문 목록 체크박스
function getCheckboxStr(){
	let str = '<label class="dhx_checkbox dhx_cell-editor__checkbox ">';
	str += '<input type="checkbox" class="dhx_checkbox__input dhx_checkbox--check-all">';
	str += '<span class="dhx_checkbox__visual-input "></span>';
	str += '</label>';
	return str;
}

// 주문 목록 생성
function showOrders(){
	flag = "order";
	if(uiNum != null){startDate2 = ''}
	if(grid){
		grid.destructor();
		grid = null;
	}
	const columns = [
		{id:'rowId', header:[{text:getCheckboxStr(), htmlEnable:true}], type:'boolean', sortable:false, editable: true},
		{id:'orId', header:[{text:'주문ID'}]},
		{id:'uiName', header:[{text:'고객명'}]},
		{id:'orPiName', header:[{text:'상품명'}]},
		{id:'credat', header:[{text:'주문일'}]},
		{id:'orStatus', header:[{text:'주문상태'}]},
		{id:'orStatusPay', header:[{text:'결제상태'}]},
		{id:'orStatusDelivery', header:[{text:'배송상태'}]},
		{id:'orItemCount', header:[{text:'주문 품목 수'}]},
		{id:'orAmount', header:[{text:'결제금액'}]},
		{id:'payNum', header:[{text:'결제번호'}]},
		{id:'payName', header:[{text:'결제자명'}]},
		{id:'payMethod', header:[{text:'결제방법'}]},
		{id:'deiReceiver', header:[{text:'수령자명'}]},
		{id:'deiInvoiceNum', header:[{text:'배송번호'}]},
		{id:'orCancle', header:[{text:'취소'}]},
		{id:'orExchange', header:[{text:'교환'}]},
		{id:'orReturn', header:[{text:'반품'}]},
		{id:'orRefund', header:[{text:'환불'}]},
		{id:'orClosedDate', header:[{text:'주문확정일'}]},
		{id:'orMemo', header:[{text:'메모'}]}
	];
	grid = new dhx.Grid('orderGrid',{
		columns : columns,
		leftSplit :0,
		adjust: true,
		dragItem:"both",
		keyNavigation : true,
		autoWidth: true,
		selection: 'row',
		eventHandlers:{
			onclick: {
				'dhx_checkbox--check-all': function(event, data) {
				grid.data.forEach(row => {
					grid.data.update(row.id, { [data.col.id]: event.target.checked });
					});
				}
			}
		}
	});
	console.log("init 당시 페이지 넘버");
	console.log(page);
	getOrderList(page);
}


async function getOrderList(pageNum){
	console.log('getOrderList에 넘어온 페이지 넘버');
	console.log(pageNum);
	page = pageNum;
	
	const params = {
		pageCount : pageCount,
		page: page,
		startDate: startDate2.replace(/-/g, ''),
		endDate: endDate.replace(/-/g, ''),
		orId: orId,
		uiName: uiName,
		uiNum: uiNum,
		payName : payName,
		deiReceiver : deiReceiver,
		orStatusPay: orStatusPay,
		orStatusDelivery: orStatusDelivery,
		orCancle: orCancle,
		orExchange: orExchange,
		orReturn: orReturn,
		orRefund: orRefund
	}
	console.log("params!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	console.log(params);
	axios.get('/orders', {params})
	.then(res => {
		const orderCount = res.data.count;
		grid.data.parse(res.data.list);
		document.querySelector('#searchResults').textContent = orderCount;
		pagination(page,orderCount,pageCount);		
	});
}

// 아이템 주문 목록 생성
function showOrderItems(){
	flag = "orderItem";
	if(grid){
		grid.destructor();
		grid = null;
	}
	const columns = [
		{id:'rowId', header:[{text:getCheckboxStr(), htmlEnable:true}], type:'boolean', sortable:false, editable: true},
		{id:'orId', header:[{text:'주문ID'}]},
		{id:'uiName', header:[{text:'고객명'}]},   
		{id:'piName', header:[{text:'상품명'}]},   
		{id:'piColorTitle', header:[{text:'색상'}]},   
		{id:'psName', header:[{text:'사이즈'}]},
		{id:'credat', header:[{text:'주문일'}]},
		{id:'oiStatus', header:[{text:'주문상태'}]},
		{id:'oiStatusPay', header:[{text:'결제상태'}]},
		{id:'oiStatusDelivery', header:[{text:'배송상태'}]},
		{id:'oiPrice', header:[{text:'판매가'}]},
		{id:'oiCount', header:[{text:'수량'}]},
		{id:'oiTotal', header:[{text:'상품별 구매총액'}]},
		{id:'payNum', header:[{text:'결제번호'}]},
		{id:'payName', header:[{text:'결제자명'}]},
		{id:'payMethod', header:[{text:'결제방법'}]},
		{id:'deiNum', header:[{text:'배송번호'}]},
		{id:'deiReceiver', header:[{text:'수령자명'}]},
		{id:'deiInvoiceNum', header:[{text:'운송장번호'}]},
		{id:'oiCancle', header:[{text:'취소'}]},
		{id:'oiExchange', header:[{text:'교환'}]},
		{id:'oiReturn', header:[{text:'반품'}]},
		{id:'oiRefund', header:[{text:'환불'}]},
		{id:'oiClosedDate', header:[{text:'주문확정일'}]},
		{id:'oiMemo', header:[{text:'메모'}]}
	];
	grid = new dhx.Grid('orderGrid',{
		columns : columns,
		leftSplit :0,
		adjust: true,
		dragItem:"both",
		keyNavigation : true,
		autoWidth: true,
		selection: 'row',
		eventHandlers:{
			onclick: {
				'dhx_checkbox--check-all': function(event, data) {
					grid.data.forEach(row => {
						grid.data.update(row.id, { [data.col.id]: event.target.checked });
					});
				}
			}
		}
	});
	console.log("item으로 넘어올 때 페이지 넘버");
	console.log(page);
	getOrderItemList(page);
}

async function getOrderItemList(pageNum){
	console.log("getOrderItemList 넘어온 페이지 넘버");
	console.log(pageNum);
	page = pageNum;
	const params={
		pageCount: pageCount,
		page: page,
		startDate: startDate2.replace(/-/g, ''),
		endDate: endDate.replace(/-/g, ''),		
		orId: orId,
		uiName:uiName,
		uiNum: uiNum,
		payName : payName,
		deiReceiver : deiReceiver,
		piName:piName,
		oiStatusPay: oiStatusPay,
		oiStatusDelivery: oiStatusDelivery,
		oiCancle: oiCancle,
		oiExchange: oiExchange,
		oiReturn: oiReturn,
		oiRefund: oiRefund
	}
	console.log("오더 아이템 params");
	console.log(params);
	axios.get('/orderItems', {params})
	.then(res => {
		const orderCount = res.data.count;
		grid.data.parse(res.data.list);
		document.querySelector('#searchResults').textContent = orderCount;
		pagination(page,orderCount,pageCount);		
	});
}

function pagination(page,orderCount,pageCount){
	let functionName = '';
	if(flag =="order"){
		functionName = "getOrderList";
	}else if(flag == "orderItem"){
		functionName = "getOrderItemList";
	}
	var html = '';
	html += '<nav aria-label="Page navigation">';
	html += '<ul class="pagination justify-content-center mt-4">';
	var startNum = ((Math.ceil(page/10))-1)*10+1;
	var lastNum = startNum + 9;
	var totalNum = Math.ceil(orderCount/pageCount);
	if(lastNum > totalNum){
		lastNum = totalNum;
	}
	if(startNum != 1){
		html += '<li class="page-item">';
		html += '<a class="page-link" href="javascript:'+functionName+'('+(startNum-1)+')" tabindex="-1">Previous</a>';
		html += '</li>';
	}
	for(var i = startNum; i <= lastNum; i++){
		if(i===page){
			html += '<li class="page-item active"><a class="page-link" href="javascript:">'+i+'</a></li>';
		}else{
			html += '<li class="page-item"><a class="page-link" href="javascript:'+functionName+'('+i+')">'+i+'</a></li>';
		}
	}
	if(lastNum != totalNum){
		html += '<li class="page-item">';
		html += '<a class="page-link" href="javascript:'+functionName+'('+(lastNum+1)+')">Next</a>';  
		html += '</li>';  
	}
	html += '</ul>';
	html += '</nav>';
	document.querySelector('#pagination').innerHTML = html;
}

//한페이지에 보여지는 주문 건 수 변경 시
function setPageCount(pageCountObj){
	pageCount = pageCountObj.value;
	if(flag=="order"){
		showOrders()
	}else if(flag=="orderItem"){
		showOrderItems();
	}
}

// 검색조건
// 주문일 선택 시 달력에 날짜 적용
function setDate(selection) {
    const startdaysToSubtract = parseInt(selection.value, 10);
    const startDate = new Date();

    // 시작 날짜 계산
    startDate.setDate(startDate.getDate() - startdaysToSubtract);
    const startDateFormatted = startDate.toLocaleDateString('ko-KR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit'
    }).replace(/\. /g, '-').replace('.', ''); // YYYY-MM-DD 형식으로 변환

    const endDate = new Date();

    // 종료 날짜 설정 (오늘)
    const endDateFormatted = endDate.toLocaleDateString('ko-KR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit'
    }).replace(/\. /g, '-').replace('.', ''); // YYYY-MM-DD 형식으로 변환

    const startDateInput = document.querySelector('#startDate');
    const endDateInput = document.querySelector('#endDate');

    // 계산된 시작 날짜와 종료 날짜 설정
    startDateInput.value = startDateFormatted;
    endDateInput.value = endDateFormatted;

    // 시작 날짜 최대값과 종료 날짜 최소값 설정
    startDateInput.setAttribute("max", endDateFormatted);
    endDateInput.setAttribute("min", startDateFormatted);
}

// Event listeners to adjust date ranges when inputs change
document.querySelector('#startDate').addEventListener('change', function () {
    const startDateValue = this.value;
    document.querySelector('#endDate').setAttribute("min", startDateValue);
});

document.querySelector('#endDate').addEventListener('change', function () {
    const endDateValue = this.value;
    document.querySelector('#startDate').setAttribute("max", endDateValue);
});

function selectPiCode(){
	const selectValue = document.querySelector('#selectCondition').value;
	if(selectValue=="5"){
		if(flag=="order"){
			alert("상품코드는 Item 별 주문 탭에서만 조회 가능합니다.");
		}
	}
}

// 검색조건 선택 후 검색 버튼을 눌렀을 때
function getFiltered(){
	// 검색어 라벨 선택 및 검색어 입력
	startDate2 = document.querySelector('#startDate').value;
	endDate = document.querySelector('#endDate').value;
	const selectElement = document.querySelector('#selectCondition');
	const selectValue = selectElement.value;
	if (selectValue=="1"){
		orId=document.querySelector('#keyword').value;
	}else if(selectValue=="2"){
		uiName=document.querySelector('#keyword').value;
	}else if(selectValue=="3"){
		payName=document.querySelector('#keyword').value;
	}else if(selectValue=="4"){
		deiReceiver=document.querySelector('#keyword').value;
	}else if(selectValue=="5"){
		if(flag=="orderItem"){
			piName=document.querySelector('#keyword').value;			
		}else if(flag=="order"){
			document.querySelector('#keyword').value = "";
			alert("상품코드는 Item 별 주문 탭에서만 조회 가능합니다.");
		}
	}
	// 결제상태, 배송상태, CS상태 선택
	const radioBoxes = document.querySelectorAll('.conditions');
	const checkedValues = Array.from(radioBoxes)
		.filter(radio => radio.checked)
		.map(radio => radio.value);
	if(flag=="order"){
		for(var checkedValue of checkedValues){
			// 배송상태 선택 
			if(checkedValue=="5"){
				orStatusDelivery = "상품준비중";
			}else if(checkedValue=="6"){
				orStatusDelivery = "배송준비중";
			}else if(checkedValue=="7"){
				orStatusDelivery = "배송중";
			}else if(checkedValue=="8"){
				orStatusDelivery = "배송완료";
			}else if(checkedValue=="9"){
				orStatusDelivery = "배송보류";
			}
			// CS상태 선택
			else if(checkedValue=="10"){
				orCancle = "processing";
			}else if(checkedValue=="11"){
				orExchange = "processing";
			}else if(checkedValue=="12"){
				orReturn = "processing";
			}else if(checkedValue=="13"){
				orRefund = "processing";
			}
		}
		showOrders(page);
	}else if(flag=="orderItem"){
		for(var checkedValue of checkedValues){
			// 배송상태 선택 
			if(checkedValue=="5"){
				oiStatusDelivery = "상품준비중";
			}else if(checkedValue=="6"){
				oiStatusDelivery = "배송준비중";
			}else if(checkedValue=="7"){
				oiStatusDelivery = "배송중";
			}else if(checkedValue=="8"){
				oiStatusDelivery = "배송완료";
			}else if(checkedValue=="9"){
				oiStatusDelivery = "배송보류";
			}
			// CS상태 선택
			else if(checkedValue=="10"){
				oiCancle = "processing";
			}else if(checkedValue=="11"){
				oiExchange = "processing";
			}else if(checkedValue=="12"){
				oiReturn = "processing";
			}else if(checkedValue=="13"){
				oiRefund = "processing";
			}
		}
		showOrderItems(page); 
	}
}

// 초기화 버튼을 클릭했을 때 검색조건 초기화
function initConditions(){
	startDate2 = today;
	endDate = today;
	orId = '';
	uiName = '';
	payName = '';
	deiReceiver = '';
	piName = '';
	orStatusPay = '';
	orStatusDelivery = '';
	orCancle = '';
	orExchange = '';
	orReturn = '';
	orRefund = '';
	oiStatusPay = '';
	oiStatusDelivery = '';
	oiCancle = '';
	oiExchange = '';
	oiReturn = '';
	oiRefund = '';
	
	document.querySelector('#startDate').value = '';
	document.querySelector('#endDate').value = '';
	document.querySelector('#selectCondition').value = 1;
	document.querySelector('#keyword').value = '';
	document.querySelectorAll('.conditions').forEach((radio) => {
		radio.checked = false;
	});
	if(flag=="order"){
		getOrderList(page);  
	}else if(flag=="orderItem"){
		getOrderItemList(page);
	}
}

function prepareProduct(){
	const rows = grid.data.serialize();
	const checkedRows = rows.filter(row=>row.rowId); // 체크된 row 전체 데이터 객체
	let param = [];
	// 선택된 체크박스들의 정보를 param 배열에 담기
	if(flag=="order"){
		for(let i = 0; i<checkedRows.length; i++){
			param.push({
				orNum : checkedRows[i].orNum,
				orStatusDelivery : "상품준비중"
			});
		}
	}else if(flag=="orderItem"){
		for(let i = 0; i<checkedRows.length; i++){
			param.push({
				oiNum : checkedRows[i].orNum,
				oiStatusDelivery : "상품준비중"
			});
		}
	}
	axios.put('/orderDelStatus', param)
	.then(res => {
		console.log(res);
		if(res.data==checkedRows.length){
			alert(res.data+"건의 주문 상태가 업데이트 되었습니다.");
			console.log(res.data+"건의 배송정보 업데이트 성공");
		}else{
			console.log("배송정보 업데이트 실패");
		}
		showOrders(page);
	});
}

function closeOrder(){
	const rows = grid.data.serialize();
	const checkedRows = rows.filter(row=>row.rowId); // 체크된 row 전체 데이터 객체
	let param = [];
	// 선택된 체크박스들의 정보를 param 배열에 담기
	if(flag=="order"){
		for(let i = 0; i<checkedRows.length; i++){
			param.push({
				orNum : checkedRows[i].orNum,
				orStatus : "closed"
			});
		}
	}else if(flag=="orderItem"){
		for(let i = 0; i<checkedRows.length; i++){
			param.push({
				oiNum : checkedRows[i].orNum,
				oiStatus : "closed"
			});
		}
	}
	axios.put('/orderStatus', param)
	.then(res => {
		console.log(res);
		if(res.data==checkedRows.length){
			alert(res.data+"건의 주문 상태가 업데이트 되었습니다.");
			console.log(res.data+"건의 배송정보 업데이트 성공");
		}else{
			console.log("배송정보 업데이트 실패");
		}
		showOrders(page);
	});
}

function completeDelivery(){
	const rows = grid.data.serialize();
	const checkedRows = rows.filter(row=>row.rowId); // 체크된 row 전체 데이터 객체
	let param = [];
	// 선택된 체크박스들의 정보를 param 배열에 담기
	if(flag=="order"){
		for(let i = 0; i<checkedRows.length; i++){
			param.push({
				orNum : checkedRows[i].orNum,
				orStatusDelivery : "배송완료"
			});
		}
	}else if(flag=="orderItem"){
		for(let i = 0; i<checkedRows.length; i++){
			param.push({
				oiNum : checkedRows[i].orNum,
				oiStatusDelivery : "배송완료"
			});
		}
	}
	axios.put('/orderDelStatus', param)
	.then(res => {
		console.log(res);
		if(res.data==checkedRows.length){
			alert(res.data+"건의 주문 상태가 업데이트 되었습니다.");
			console.log(res.data+"건의 배송정보 업데이트 성공");
		}else{
			console.log("배송정보 업데이트 실패");
		}
		showOrders(page);
	});
}

function holdDelivery(){
	const rows = grid.data.serialize();
	const checkedRows = rows.filter(row=>row.rowId); // 체크된 row 전체 데이터 객체
	let param = [];
	// 선택된 체크박스들의 정보를 param 배열에 담기
	if(flag=="order"){
		for(let i = 0; i<checkedRows.length; i++){
			param.push({
				orNum : checkedRows[i].orNum,
				orStatusDelivery : "배송보류"
			});
		}
	}else if(flag=="orderItem"){
		for(let i = 0; i<checkedRows.length; i++){
			param.push({
				oiNum : checkedRows[i].orNum,
				oiStatusDelivery : "배송보류"
			});
		}
	}
	axios.put('/orderDelStatus', param)
	.then(res => {
		console.log(res);
		if(res.data==checkedRows.length){
			alert(res.data+"건의 주문 상태가 업데이트 되었습니다.");
			console.log(res.data+"건의 배송정보 업데이트 성공");
		}else{
			console.log("배송정보 업데이트 실패");
		}
		showOrders(page);
	});
}