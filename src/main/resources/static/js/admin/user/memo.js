/* memo */
function memo(number){
  const param ={
    uiNum : number
  }
  axios.post('/memo2', param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
		if(response.data.length == 0){
			setMemo(param);
		}else{
      setMemo(response.data);
		}
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function setMemo(memo){
  document.querySelector('#modal-body').innerHTML = '';
  document.querySelector('.modal-title').innerText = '메모';
  document.querySelector('.modal-footer').innerHTML = '';
  document.querySelector('#modal-body').innerHTML = 
    '<textarea id="memocontent" name="memocontent" rows="4" cols="50" class="form-control"></textarea>';
  
  if(memo.umMemoStatus=='1'){
    document.querySelector('#memocontent').innerHTML = memo.umMemo;
    document.querySelector('.modal-footer').innerHTML += 
    '<button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal" onClick="deleteMemo('+memo.umNum+')">삭제</button>';  
    document.querySelector('.modal-footer').innerHTML += 
    '<button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal" onClick="updateMemo('+memo.umNum+')">수정</button>';  
  }

  document.querySelector('.modal-footer').innerHTML += 
  '<button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal" onClick="saveMemo('+memo.uiNum+')">새로 저장</button>'; 
  document.querySelector('.modal-footer').innerHTML += 
  '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>'; 
};
function saveMemo(number){
	console.log("saveMemo number: "+number);
  const param = {
    uiNum : number,
    umMemo : document.querySelector('#memocontent').value
  }
	console.log(number);
  axios.post('/memo', param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
    if(response.data=='1'){
      alert('메모 등록 성공');
    }
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function updateMemo(number){
  const param = {
    umNum : number,
    umMemo : document.querySelector('#memocontent').value
  }
  axios.put('/memo', param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
    if(response.data=='1'){
      alert('메모 수정 성공');
    }
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function deleteMemo(umNum){
	const param = {
    umNum : umNum,
  }
  axios.delete('/memo', {
		data: param,
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
		// 응답 확인
    if (response.data == '1') {
      alert('메모 삭제 성공');
    } else {
      alert('메모 삭제 실패');
    }
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}