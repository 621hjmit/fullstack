let userObject = null;
let ubNum;
let uiNum;
let userObjectFromDB = null;

window.onload = init;
function init(){
  if(!user){
    location.href='/views/user/login';
  }else{
    userObject = Object.fromEntries(
      user.match(/(\w+)=([^,]+)/g).map(pair => pair.split('='))
    );
    uiNum = userObject.uiNum;
    const urlParams = new URLSearchParams(window.location.search);
    ubNum = urlParams.get('ubNum'); // "12345" 값이 반환됩니다.
    getData();
    getType();
    
  }
}

function getType(){
  axios.get('/user-contact',{
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(res => {
    fillData2(res.data);
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function getData(){
  const param = {
    ubNum : ubNum 
  }
  axios.post('/board-contact-view',param,{
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(res => {
    fillData(res.data);
    userObjectFromDB = res;
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function fillData(user){
  for (let key in user) {
    //console.log(key+' '+user[key]);
    // user 객체의 각 key에 해당하는 id를 가진 요소가 있을 경우
    let element = document.getElementById(key); // key에 해당하는 id를 가진 요소를 찾음
    if (element) { // 요소가 존재한다면
      element.value = user[key]; // 요소에 값을 넣어줌
    }
    if(key=='ucNum'){
      element.dataset.num = user[key];
    }
  }
}
function fillData2(data){
  let htmlContent = '';
  for (let i = 0; i < data.length; i++) {
    htmlContent += '<option value="'+data[i].ucNum+'">'+data[i].ucTitle+'</option>';
  }
  const ucNum = document.querySelector('#ucNum');
  ucNum.innerHTML += htmlContent;
  ucNum.value = ucNum.dataset.num;
}
function check(object, num){
  if(object==''){
    alert("입력란에 내용을 넣어주세요.");
    object.focus();
    return;
  }else if(object.length >= num){
    alert("내용의 길이가 너무 깁니다.");
    object.focus();
    return;
  }
}

function save(){
  const uiLastName    = document.querySelector('#ubLastName').value   ;
  const uiFirstName   = document.querySelector('#ubFirstName').value  ;
  const uiEmail       = document.querySelector('#ubEmail').value      ;
  const uiCountryCode = document.querySelector('#ubCountryCode').value;
  const uiPhone       = document.querySelector('#ubPhone').value      ;
  const ubMessage     = document.querySelector('#ubMessage').value  ;
  const ubTitle       = document.querySelector('#ubTitle').value  ;
  
  // 셀렉트박스 접근
  const selectBox = document.querySelector("#ucNum");
  // 선택된 옵션 접근
  const csSubject = selectBox.options[selectBox.selectedIndex].value;
  
  check(uiLastName,50);
  check(uiFirstName,50);
  check(uiEmail,255);
  check(uiCountryCode,5);
  check(uiPhone,50);
  check(csSubject,255);
  check(ubMessage,1000);
  
  const param = {
    ubLastName    :uiLastName,
    ubFirstName   :uiFirstName,
    ubEmail       :uiEmail,
    ubCountryCode :uiCountryCode,
    ubPhone       :uiPhone,
    ucNum         :csSubject,
    ubMessage     :ubMessage,
    ubTitle       :ubTitle,
    ubNum         :ubNum
  }
  sendToDBForSave(param);
}

function sendToDBForSave(param1){
  axios.put('/contact', param1  , {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(res => {
    if(res.data=='1'){
      alert('문의 내용이 수정되었습니다.');
      location.href='/views/user/board-contact-view?ubNum='+ubNum;
    }else{
      alert('1:1 문의 수정에 실패하였습니다. 관리자에게 문의 하세요.');
    }
  })
  .catch(error => {
    console.error('There was an error!', error);
  });
}