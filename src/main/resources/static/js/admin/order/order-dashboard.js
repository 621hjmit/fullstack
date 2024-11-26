window.onload = init;

function init(){
	document.title = "고객 대쉬보드 | Hermes Admin";
	getOrderData();
	/*getNewMember();*/
	/*modal();*/
}

const today = new Date().toLocaleDateString('ko-KR', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit'
}).replace(/\. /g, '-').replace('.', '');

let endDate = today;

// 한 달 전 날짜 계산
const date = new Date();
date.setMonth(date.getMonth() - 1);

const startDate = date.toLocaleDateString('ko-KR', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit'
}).replace(/\. /g, '-').replace('.', '');

function getOrderData(){
	let params = {
		startDate : startDate,
		endDate : endDate
	}
	axios.get("/orderDashboard",{params})
	.then(res =>{
		console.log(res.data);
		document.querySelector('#totalAmountToday').innerText = res.data.totalAmountToday.toLocaleString();
		document.querySelector('#totalCountToday').innerText = res.data.totalCountToday;
		document.querySelector('#totalAmountMonth').innerText = res.data.totalAmountMonth.toLocaleString();
		document.querySelector('#totalCountMonth').innerText = res.data.totalCountMonth;
		document.querySelector('#refundAmountToday').innerText = res.data.refundAmountToday.toLocaleString();
		document.querySelector('#refundCountToday').innerText = res.data.refundCountToday;
		document.querySelector('#refundAmountMonth').innerText = res.data.refundAmountMonth.toLocaleString();
		document.querySelector('#refundCountMonth').innerText = res.data.refundCountMonth;
		document.querySelector('#newOrder').innerText = res.data.newOrder;
		document.querySelector('#prepProduct').innerText = res.data.prepProduct;
		document.querySelector('#prepDelivery').innerText = res.data.prepDelivery;
		document.querySelector('#holdDelivery').innerText = res.data.holdDelivery;
		document.querySelector('#onDelivery').innerText = res.data.onDelivery;
		/*document.querySelector('#pendingOrder').innerText = res.data;*/
		document.querySelector('#cancleOrder').innerText = res.data.cancleOrder;
		document.querySelector('#exchangeOrder').innerText = res.data.exchangeOrder;
		document.querySelector('#returnOrder').innerText = res.data.returnOrder;
		document.querySelector('#refundOrder').innerText = res.data.refundOrder;
	})
}