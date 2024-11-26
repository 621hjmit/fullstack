<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>

<!-- [Page specific CSS] start -->
<link rel="stylesheet" href="https://snippet.dhtmlx.com/codebase/assets/css/auxiliary_controls.css">
<!-- [Page specific CSS] end -->

<!-- [ Main Content ] start -->
<div class="pc-container">
	
	<div class="pc-content">
<!-- [ page title ] start -->
		<div class="page-header">
			<div class="page-block">
				<div class="row align-items-center">
					<div class="col-md-12">
						<div class="page-header-title">
							<h3 class="mb-0"><b>택배사 정보관리</b></h3>
						</div>
					</div>
				</div>
			</div>
		</div>
<!-- [ page title ] end -->

<!-- [ block1 ] start -->
		<div class="col-sm-12">
			<div class="card table-card">
				<div class="card-body p-4 ">
					<section class="dhx_sample-controls">
    					<label for="search" class="dhx_sample-label">Search:</label>
						<input id="search" class="dhx_sample-input" style="width: 200px">
					</section>
					<div id="deliveryComGrid" style="width: 100%; height: 50vh;">
					</div>
				</div>
			</div>
		</div>
<!-- [ block1 ] end -->

<!-- [ block2 ] start -->
		<div class="col-sm-12">
			<div class="card-body p-4 text-center">
				<div class="btn-group" role="group">
					<div class="text-center">
						<button onclick="add()" type="button" class="btn btn-primary">추가</button>
						<button onclick="modify()" type="button" class="btn btn-light btn-outline-primary">저장</button>
						<button onclick="deleteDeliveryCom()" type="button" class="btn btn-danger">삭제</button>
					</div>
				</div>
			</div>
		</div>
<!-- [ block2 ] end -->
	</div>
</div>

<script>
	var grid;
	const input = document.getElementById("search");
	input.addEventListener("input", event=>{
		const value = event.target.value.toString().toLowerCase();
		grid.data.filter(obj=>{
			return Object.values(obj).some(item=>
				item.toString().toLowerCase().includes(value)
			);
		});
	});
	function getCheckboxStr(){
		let str = '<label class="dhx_checkbox dhx_cell-editor__checkbox ">';
		str += '<input type="checkbox" class="dhx_checkbox__input dhx_checkbox--check-all">';
		str += '<span class="dhx_checkbox__visual-input "></span>';
		str += '</label>';
		return str;
	}
	function init(){
		const columns = [
			{width:45, id:'rowId', header:[{text:getCheckboxStr(), htmlEnable:true}], type:'boolean', sortable:false},
			{width:55, id:'dciNum', header:[{text:'번호'}], editable:false},
			{width:90, id:'dciName', header:[{text:'택배사명'}]},
			{width:200,id:'dciId', header:[{text:'CODE'}]},
			{width:80, id:'dciContact', header:[{text:'담당자'}]},
			{width:150,id:'dciPhone', header:[{text:'연락처'}]},
			{width:250,id:'dciEmail', header:[{text:'이메일'}]},
			{width:100,id:'dciStartDate', header:[{text:'계약시작일'}]},
			{width:100,id:'dciEndDate', header:[{text:'계약만료일'}]},
		];
		grid = new dhx.Grid('deliveryComGrid',{
			columns : columns,
			leftSplit :1,
			adjust: true,
			editable: true,
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
		getDeliveryComs();
	}

	async function getDeliveryComs(){
		const res = await axios.get('/deliveryComs');
		grid.data.parse(res.data);
	}
	
	function add(){
		const newRow = {
				dciNum:0,
				dciName:'',
				dciId:'',
				dciContact:'',
				dciPhone:'',
				dciEmail:'',
				dciStartDate:'',
				dciEndDate:''
		}
		grid.data.add(newRow);
	}
	function modify(){
		const rows = grid.data.serialize();
		const checkedRows = rows.filter(row=>row.rowId);
		console.log(checkedRows);
		let result;
		axios.post('/deliveryComs', checkedRows)
		.then(res=>{
			result = res.data;
			alert(result + '개의 정보가 저장되었습니다.');
			getDeliveryComs();
		})
		.catch(err=>{
			alert(err.response.data.message);
		});
	}
	function deleteDeliveryCom(){
		const rows = grid.data.serialize();
		const checkedRows = rows.filter(row=>row.rowId);
		const dciNums = rows.filter(row=>row.rowId).map(row=>row.dciNum);
		axios.delete('/deliveryComs',{data:dciNums})
		.then(res=>{
			result = res.data;
			alert(result + '개의 정보가 삭제되었습니다.');
			getDeliveryComs();
		});
	}
	window.addEventListener('load', init);
	
</script>

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>