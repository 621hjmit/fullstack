let userObject = null;
let ubNum;
window.onload = init;
function init(){
  if(!user){
    location.href='/views/user/login';
  }else{
    userObject = Object.fromEntries(
      user.match(/(\w+)=([^,]+)/g).map(pair => pair.split('='))
    );
    const urlParams = new URLSearchParams(window.location.search);
    ubNum = urlParams.get('ubNum'); // "12345" 값이 반환됩니다.
    getData('#boardContent');
  }
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
function getData(elementID){
  const param = {
    uiNum : userObject.uiNum,
    ubNum : ubNum 
  }
  axios.post('/board-contact-view', param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(res => {
    res = res.data;
    let htmlContent ='';
    const item = res;
    htmlContent += 
      '<tr>'+
        '<td class="ta-center">'+ item.ucTitle + '</td>'+
        '<td class="ta-center"><a href="/views/user/board-contact-view?umNum='+item.ubNum+'">'+ item.ubTitle + '</a></td>'+
        '<td class="ta-center">'+ item.ubCredat + '</td>'+
      '</tr>'+
      '<tr>'+
        '<td colspan="3" class="p-20-i">'+ item.ubMessage + '</td>'+
      '</tr>';
    document.querySelector(elementID).innerHTML += htmlContent;
    if(item.ubReplyMessage){
      document.querySelector('#ubReplyMessage').innerHTML = item.ubReplyMessage;
      document.querySelector('#ubReplyCredat').innerHTML = item.ubReplyCredat;
      document.querySelector('#reply').classList.remove('hidden');
    }
    
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function updateInquiryRecord(){
  location.href = "/views/user/board-contact-modify?ubNum="+ubNum;
}
function deleteInquiryRecord(){
  // 선택된 체크박스들의 정보를 param 배열에 담기
  // Axios로 PUT 요청 보내기
  axios.delete('/board-contact/'+ubNum,  {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
    alert("고객님의 1:1 문의내역을 삭제하였습니다.");
    location.href="/views/user/board-contact";
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}