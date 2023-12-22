<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모달 창 예제</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- Bootstrap-datepicker CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<!-- Bootstrap JS -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- Bootstrap-datepicker JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
</head>
<body>

	<!-- 버튼을 클릭하면 모달 창을 띄우기 위한 버튼 -->
	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#myModal">모달 창 열기</button>

	<!-- 모달 창 정의 -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">

			<!-- 모달 창 내용 -->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">발주요청입력</h4>
				</div>
				<div class="modal-body">
					<ul class="wrapper-form wrapper-form-state-2">
						<li>
							<div class="title">일자</div>
							<div class="form-group">
								<input type="text" class="form-control" id="datepicker1"
									name="date" readonly>
							</div>
						</li>
						<li>
							<div class="title">담당자</div>
							<div class="form-group">
								<input type="text" class="form-control"> <input
									type="text" class="form-control">
							</div>
						</li>

						<li>
							<div class="title">입고될창고</div>
							<div class="form-group">
								<input type="text" class="form-control"> <input
									type="text" class="form-control">
							</div>
						</li>

						<li>
							<div class="title">납기일자</div>
							<div class="form-group">
								<input type="text" class="form-control" id="datepicker2"
									name="date" readonly>
							</div>
						</li>

						<li>
							<div class="title">새로운 항목 추가</div>
							<div class="form-group">
								<input type="text" class="form-control"
									placeholder="다양한 항목을 추가하여 활용할 수 있습니다." required>
							</div>
						</li>

						<li>
							<div class="title">첨부</div>
						</li>
					</ul>

					<table class="table">
						<thead>
							<tr>
								<th>품목코드</th>
								<th>품목명</th>
								<th>거래처코드</th>
								<th>거래처명</th>
								<th>규격</th>
								<th>수량</th>
								<th>단가</th>
								<th>금액(합계)</th>
								<th>새로운 항목 추가</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" class="form-control"
									name="itemCode[]"></td>
								<td><input type="text" class="form-control"
									name="itemName[]"></td>
								<td><input type="text" class="form-control"
									name="supplierCode[]"></td>
								<td><input type="text" class="form-control"
									name="supplierName[]"></td>
								<td><input type="text" class="form-control"
									name="specification[]"></td>
								<td><input type="text" class="form-control"
									name="quantity[]" oninput="calculateTotal(this)"></td>
								<td><input type="text" class="form-control"
									name="unitPrice[]" oninput="calculateTotal(this)"></td>
								<td><input type="text" class="form-control"
									name="totalAmount[]" readonly></td>
								<td><input type="text" class="form-control" name="newNote"></td>
							</tr>
						</tbody>
					</table>
					<button class="btn btn-primary" onclick="addRow()">추가</button>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button onclick="saveData()" class="btn btn-primary">저장</button>
					<button onclick="resetForm()" class="btn btn-default">다시
						작성</button>
				</div>
			</div>
		</div>
	</div>


	<script>
	// 추가 버튼 누르면 입력란 한줄 더 생김
    function addRow() {
        var tableBody = document.querySelector('table tbody');
        var newRow = tableBody.insertRow();
        
        newRow.innerHTML = `
            <td><input type="text" class="form-control" name="itemCode[]"></td>
            <td><input type="text" class="form-control" name="itemName[]"></td>
            <td><input type="text" class="form-control" name="supplierCode[]"></td>
            <td><input type="text" class="form-control" name="supplierName[]"></td>
            <td><input type="text" class="form-control" name="specification[]"></td>
            <td><input type="text" class="form-control" name="quantity[]" oninput="calculateTotal(this)"></td>
            <td><input type="text" class="form-control" name="unitPrice[]" oninput="calculateTotal(this)"></td>
            <td><input type="text" class="form-control" name="totalAmount[]" readonly></td>
            <td><input type="text" class="form-control" name="newNote"></td>
        `;
    }

	// 단가 * 수량 = 금액 계산
    function calculateTotal(input) {
        var row = input.closest('tr');
        var quantity = row.querySelector('[name="quantity[]"]').value;
        var unitPrice = row.querySelector('[name="unitPrice[]"]').value;
        var totalAmountInput = row.querySelector('[name="totalAmount[]"]');
        var totalAmount = quantity * unitPrice;
        totalAmountInput.value = isNaN(totalAmount) ? '' : totalAmount;
    }
	
	// 다시 작성
    function resetForm() {
        var inputs = document.querySelectorAll('input[type="text"]');
        inputs.forEach(function(input) {
            input.value = '';
        });
    }
	
	$(document).ready(function() {
		// Initialize datepicker
		$('#datepicker1').datepicker({ // 일자
			format : 'yyyy-mm-dd', 
			todayHighlight : true,
			autoclose : true
		});

		$('#datepicker2').datepicker({ // 납기일자
			format : 'yyyy-mm-dd', 
			todayHighlight : true,
			autoclose : true
		});
	});
	
	</script>

</body>
</html>