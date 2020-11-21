	function openTab(evt, tabName) {
		var i, content, tap;
		
		content = document.getElementsByClassName('content');
		for (i=0 ; i<content.length ; i++) {
			content[i].classList.remove('on');
		}
		
		tap = document.getElementsByClassName('tab');
		for (i=0 ; i<tap.length ; i++) {
			tap[i].classList.remove('active');
		}
		
		document.getElementById(tabName).classList.add('on');
		evt.currentTarget.classList.add('active');
	}