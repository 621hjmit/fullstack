<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
<!-- [Page specific CSS] start -->
<!-- DatePicker 먼저 로드하고 그다음에 유저를 로드해야합니다. -->
<script src="/static/assets/js/plugins/bootstrap-datepicker.min.js"></script>
<script src="/static/js/admin/user/news.js"></script>
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
              <h2 class="mb-0">뉴스레터 구독자 관리</h2>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- [ page title ] end -->
    
    <div class="row">
      
      <!-- [ block1 : 회원 현황 ] start -->
      <div class="col-lg-3">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <div class="mb-4">
              <label class="form-label">개인정보:</label>
              <select class="form-select form-select-sm mb-2" id="searchType">
                <option value="1">성</option>
                <option value="2">이름</option>
                <option value="3">이메일</option>
                <option value="4">휴대폰번호</option>
              </select>
              <input class="form-control form-control-sm" type="text" placeholder="검색어 입력" id="searchText">
            </div>
            <div class="mb-4">
              <label class="form-label">구독 상태:</label><br>
              <div class="text-center">
	              <div class="btn-group" role="group" id="newsStatus">
	                <input type="radio" class="btn-check" id="all" name="newsStatus" value="all">
	                <label class="btn btn-outline-info" for="all">전체</label>
	                <input type="radio" class="btn-check" id="active" name="newsStatus" value="active">
	                <label class="btn btn-outline-info" for="active">구독중</label>
	                <input type="radio" class="btn-check" id=unsubscribed name="newsStatus" value="unsubscribed">
	                <label class="btn btn-outline-info" for="unsubscribed">구독해지</label>
	                <input type="radio" class="btn-check" id="bounced" name="newsStatus" value="bounced">
	                <label class="btn btn-outline-info" for="bounced">전송 실패</label>
	              </div>
              </div>
            </div>
            <div class="mb-4">
              <label class="form-label">기간:</label><br/>
              <div class="btn-group mb-3" role="group">
							<input type="radio" class="btn-check" id="allPeriod" name="period" value="999">
							<label class="btn btn-outline-info" for="allPeriod">전체</label>
							<input type="radio" class="btn-check" id="today" name="period" value="0">
							<label class="btn btn-outline-info" for="today">오늘</label>
							<input type="radio" class="btn-check" id="three" name="period" value="2">
							<label class="btn btn-outline-info" for="three">3일</label>
							<input type="radio" class="btn-check" id="seven" name="period" value="6">
							<label class="btn btn-outline-info" for="seven">7일</label>
							<input type="radio" class="btn-check" id="month" name="period" value="29">
							<label class="btn btn-outline-info" for="month">30일</label>
							<input type="radio" class="btn-check" id="year" name="period" value="364">
							<label class="btn btn-outline-info" for="year">1년</label>
						</div>
						<div class="input-daterange input-group " id="datepicker_range">
                <input type="text" class="form-control text-left" placeholder="시작일" name="range-start" >
                <input type="text" class="form-control text-end" placeholder="종료일" name="range-end" >
              </div>
            </div>
            <div class="text-center">
              <button type="button" class="btn btn-primary" onclick="getMemberInfo()">검색</button>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block1 : 회원 현황 ] end -->
      
      <!-- [ block2 : 최근 가입 회원 ] start -->
      <div class="col-lg-9">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <h4 class="mb-2 pt-2 "><span id="pageTitle">회원 목록</span>
              <button type="button" class="btn btn-icon btn-link-primary avtar-xs" data-bs-toggle="popover" 
              data-bs-title="회원 목록"  data-bs-placement="bottom" data-bs-html="true"
              data-bs-content="
              <ul>
                <li>삭제 시 회원의 미완료 주문 여부, 적립금 여부를 확인하며 미완료 주문이 있는 경우 삭제되지 않습니다.</li>
                <li>[자세히보기]를 체크하면 각 회원의 적립금, 예치금, 접속, 주문, 총 주문금액, 총 실결제금액을 확인할 수 있습니다.</li>
                <li>해당 기능은 100개 이하 목록에서는 바로 확인할 수 있으며, 200개 이상은 [관련 내역 보기]의 각 버튼을 통해 확인할 수 있습니다.</li>
                <li>휴면회원의 개인정보는 분리, 보관되어 쇼핑몰 관리자의 '고객관리 > 회원관리 > 휴면회원 관리'에서 별도로 조회할 수 있으며, 휴면회원이 로그인시 자동으로 휴면해제가 됩니다.</li>
                <li>일반전화 또는 스마트폰 아이콘을 클릭하면 전화상담메모 창을 띄웁니다.</li>
              </ul>">
              <i class="ti ti-info-circle"></i></button>
            </h4>
            <div class="mb-2 d-flex justify-content-between align-items-center">
              <div class="flex-grow-1">
                [총 회원수 <span class="totalResults"></span>명] 검색결과 <span class="totalResults"></span>건
                <button class="btn btn-icon btn-link-warning avtar-xs"><i class="ph-duotone ph-star"></i></button>특별관리회원
                <button class="btn btn-icon btn-link-danger avtar-xs"><i class="ph-duotone ph-warning-circle"></i></button>불량회원
              </div>
              <select class="form-select form-select-sm width-120px" id="countPerPage" onchange="setCount(this)">
                <option value="10">10개씩 보기</option>
                <option value="20">20개씩 보기</option>
                <option value="30">30개씩 보기</option>
                <option value="40">40개씩 보기</option>
                <option value="50">50개씩 보기</option>
                <option value="100">100개씩 보기</option>
                <option value="200">200개씩 보기</option>
                <option value="500">500개씩 보기</option>
                <option value="1000">1000개씩 보기</option>
              </select>
            </div>
            <div class="mb-3">
              <button type="button" class="btn btn-outline-primary btn-sm" onclick="setSub(true)">구독 설정</button>
              <button type="button" class="btn btn-outline-danger btn-sm" onclick="setSub(false)">구독 해지 설정</button>
            </div>
            <div class="table-responsive" id="dataTable">
              <table class="table  table-bordered align-middle">
                <thead class="text-center">
                  <tr>
                    <th scope="col"><input type="checkbox" onclick="check_all('check', this);" class="allChk"></th>
                    <th scope="col">구독날짜</th>
                    <th scope="col">이름</th>
                    <th scope="col">이메일</th>
                    <th scope="col">휴대폰번호</th>
                    <th scope="col">구독상태</th>
                    <th scope="col">구독해지일</th>
                    <!-- <th scope="col">메일/SMS/메모</th> -->
                  </tr>
                </thead>
                <tbody class="text-center " id="userList">
                </tbody>
              </table>
              <!-- [ Pagination ] start -->        
	            <nav id="pagination" aria-label="Page navigation example"></nav>
	            <!-- [ Pagination ] end -->
            </div>
            <div class="no-result text-center mt-5 mb-5 visually-hidden">
              검색된 회원 내역이 없습니다.
            </div>
            <div class="mb-3">
              <button type="button" class="btn btn-outline-primary btn-sm" onclick="setSub(true)">구독 설정</button>
              <button type="button" class="btn btn-outline-danger btn-sm" onclick="setSub(false)">구독 해지 설정</button>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block3 : done ] end -->
    </div>
  </div>
</div>
<!-- [ Main Content ] end -->

<!-- [Page Specific JS] start -->
<script src="/static/assets/js/plugins/simple-datatables.js"></script>

<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>