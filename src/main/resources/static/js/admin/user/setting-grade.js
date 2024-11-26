/**
 * 
 */
window.onload = init;
function init(){
  setPage();
  getData();
}
//그냥 펑션들
function setPage(){
  let str = document.querySelector(".page-header-title>h2").textContent;
  document.title = str + " | Hermes Admin";
}
function check_all(className, checkbox) {
  // 전체 선택 체크박스를 클릭했을 때, 모든 개별 체크박스를 해당 상태로 설정
  var checkboxes = document.querySelectorAll('.' + className);
  checkboxes.forEach(function (checkboxItem) {
    checkboxItem.checked = checkbox.checked;
  });
}
// 개별 체크박스를 클릭할 때
function check(checkbox) {
    // 전체 선택 체크박스 상태를 업데이트
    var allCheckbox = document.querySelector('.allChk');
    var checkboxes = document.querySelectorAll('.check');
    // 모든 개별 체크박스가 체크되었는지 확인
    var allChecked = true;
    checkboxes.forEach(function (checkboxItem) {
        if (!checkboxItem.checked) {
            allChecked = false;
        }
    });
    // 전체 선택 체크박스의 상태를 업데이트
    if (allChecked) {
        allCheckbox.checked = true;
    } else {
        // 개별 체크박스가 하나라도 체크되지 않으면 전체 선택 체크박스를 해제
        allCheckbox.checked = false;
    }
}
// 악시오스 존
function insert(){
	let name = $("#name").val();
	let desc = $("#desc").val();
	const param =	{
     giName: name,
     giDesc: desc
  }; 
	console.log(name);
	console.log(desc);
	axios.post('/grade'	,param, 
	{
 	  headers: {
 	    'Content-Type': 'application/json'
 	  }
 	})
  .then(response => {
		let result = response.data >0?"회원등급 추가에 성공하였습니다.":"회원 등급 추가에 실패하였습니다.";
    alert(result);
		getData();
  })
  .catch(error => {
    console.error('Error fetching statistics:', error);
  });
}
function printData(response){
	const gradeList = document.querySelector('#gradeList'); // 테이블의 tbody 요소
  gradeList.innerHTML ='';
	const list = response; // List<StatisticsVO> 데이터를 받아옴
  list.forEach(item => {
    const row = document.createElement('tr');
    row.innerHTML = 
			 '<td><input type="checkbox" onclick="check(this)" class="check" value="'+item.giNum  + '" name="giNum"></td>'
			+'<td><input class="form-control " type="text" value="'+item.giName + '" name="giName"></td>'
			+'<td><input class="form-control " type="text" value="'+item.giDesc + '" name="giDesc"></td>'
			+'<td><input class="form-control w-50px text-center" type="text" value="'+ item.giOrder+'" name="giOrder"></td>';
    gradeList.appendChild(row);
	})
}
function getData(){
	axios.get('/grade')
  .then(response => {
    printData(response.data);
  })
  .catch(error => {
    console.error('Error fetching statistics:', error);
  });
}
function deleteGrades(){
  const checkedObjs = document.querySelectorAll('input[name=giNum]:checked');
  const param = [];
  for(const checkObj of checkedObjs){
    param.push(checkObj.value);
  }
  const xhr = new XMLHttpRequest();
  xhr.open('DELETE','/grades');
  xhr.onreadystatechange = function(){
    if(xhr.readyState === xhr.DONE){
      if(xhr.status === 200){
        if(xhr.responseText>0){
          alert(xhr.responseText+ "개의 행을 삭제하였습니다.")
        }
        getData();
      }
    }
  }
  xhr.setRequestHeader('Content-Type','application/json');
  console.log(param);
  xhr.send(JSON.stringify(param));
}
function updateGrades(){
  const checkedObjs = document.querySelectorAll('input[name=giNum]');
  const giNames = document.querySelectorAll('input[name=giName]');
  const giDescs = document.querySelectorAll('input[name=giDesc]');
  const giOrders = document.querySelectorAll('input[name=giOrder]');
  const param = [];
  for(const idx in checkedObjs){
    const checkedObj = checkedObjs[idx];
    if(checkedObj.checked){
      param.push({
        giNum : checkedObj.value,
        giName : giNames[idx].value,
        giDesc : giDescs[idx].value,
        giOrder : giOrders[idx].value
      });
    }
  }
  console.log(param);
  const xhr = new XMLHttpRequest();
  xhr.open('PUT','/grades');
  xhr.onreadystatechange = function(){
    if(xhr.readyState === xhr.DONE){
      if(xhr.status === 200){
        alert(xhr.responseText);
      }
    }
  }
  xhr.setRequestHeader('Content-Type','application/json');
  xhr.send(JSON.stringify(param));
}