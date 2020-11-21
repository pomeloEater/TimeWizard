<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://unpkg.com/frappe-charts@1.1.0"></script>
<link rel="stylesheet" href="/timewizard/css/personal_weekly.css">
</head>
<body>
<%	
	UserInfoDto linked = (UserInfoDto) session.getAttribute("linked");
	UserInfoDto login = (UserInfoDto)session.getAttribute("login");
%>

	<div id="chart" style="width: 100%;"></div>
	<script>
	var user_no = ${linked.user_no};

	$(document).ready(function(){
		daylist(user_no);

	});
	function daylist(user_no){
		$.ajax({
			type: "post",
			url: "/timewizard/weekly/"+user_no,
			dataType: "json",
			contentType: "application/json",
			success: function(data){
				let week = data.the_date;
				let temp = week.split(", ");
				let labels = new Array();
				for(var i=0; i<temp.length; i++){
					labels.push(temp[i]);
					
				}
			
				let complete = data.complete;
				let temp2 = complete.split(", ");
				let dataset1values = new Array();
				for(var i=0; i<temp2.length; i++){
					dataset1values.push(temp2[i]);
				}
			
				let uncomplete = data.uncomplete;
				let temp3 = uncomplete.split(", ");
				let dataset2values = new Array();
				for(var i=0; i<temp3.length; i++){
					dataset2values.push(temp3[i])
				}
				
				let chartdata = {
						labels: labels,
						datasets: [
							{
								name: "complete list",type:"bar",
								chartType:"bar",
								values:dataset1values
							},
							{
								name:"not complete list",type:"bar",
								chartType:"bar",
								values: dataset2values
							}
						]
				}
				
				chart(chartdata);
			},
			error: function(data){
				alert("weekly 통신실패 ㅠㅠㅠ!!!");
			}
		});
	}

	//차트 부분
	function chart(data){
	
			let chart = new frappe.Chart("#chart", {  // or a DOM element,
			                                            // new Chart() in case of ES6 module with above usage
			    title: "✨당신의 한 주✨",
			    data: data,
			    type: 'axis-mixed', // or 'bar', 'line', 'scatter', 'pie', 'percentage', 'axis-mixed'
			    height: 300,
			    colors: ['#679ab8','#3d5c6e'],
			  
			})
	}

	</script>
	
</body>
</html>