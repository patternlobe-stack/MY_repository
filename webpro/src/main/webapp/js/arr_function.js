/**
 * 
 */

const arr= ["바나나", "사과","복숭아","딸기" , "포도","사과", "수박" , "사과"];

const proc1 = () =>{
	
	//찾는 과일 잊력 
	let item = (prompt("과일 입력"));
	
	let str="";
	
	let frvalue = arr.find(function(fr, index){
		 return fr === item;  //같으면 fr를 리턴 
		 
		 //if(fr ==== item) return fr;
		 //없으면 undefined를 리턴 
		 //undefined 비교시 typeof를 사용 
	})
	
	str += `찾는 과일 : ${item}<br>`;
	if(typeof frvalue == "undefined"){
		str += "없어요"
	}else {
		str += "있어요";
	}
	
	document.querySelector("#result1").innerHTML = str;
	
}

const proc2 = () =>{
	
	let idx = parseInt(prompt("인덱스를 입력"));
	
	let frvalue = arr.find(function(fr, index){
		 return idx === index; //fr를 리턴 
	})
	
	
	let str = "";
	if(typeof frvalue == "undefined"){
			str += `인덱스가 ${idx} 번째의 항목 없어요<br>`
  	}else{
		str += `인덱스가 ${idx} 번째의 항목  ${frvalue}<br>`;
	}
		
	document.querySelector("#result2").innerHTML = str;
		
		
}


const proc3 = () =>{
	const nums = [11,22,33,44,55,66];
	
	//짝수 
	let fvalue = nums.find( (num, index) =>{
		return num % 2 == 0
	})
	
	let str = "짝수 요소 찾기<br>";
	
	str += `${nums} <br>`;
	
	if(typeof fvalue == "undefined"){
				str += `짝수 항목 없어요<br>`
  	}else{
		str += `짝수 항목  ${fvalue}<br>`;
	}
		
	document.querySelector("#result3").innerHTML = str;
			
}

const proc4 = () =>{
	//찾는 과일 잊력 
	let item = (prompt("과일 입력"));
		
	let str="";
	
	let idx = arr.findIndex( (fr,index) =>{
		return fr === item ; // index를 리턴 
	})
	
	str += `찾는 과일 : ${item}<br>`;
	if(idx == -1){
		str += "없습니다"
	}else{
		str += `${idx} 번째 있어요`
	}
	document.querySelector("#result4").innerHTML = str;	
}

const proc5 = () =>{
	const nums = [10,5,9,20,56,1];
	//모든 짝수 찾기 
	
	let even = nums.filter(function(num, index){
		return num % 2 == 0; //num를 리턴
	})
	
	let str = `${nums} <br>`;
	str += `짝수들 : ${even}<br>`
	
	document.querySelector("#result5").innerHTML = str ;	
	
	//모든 사과 찾기 
	
	let item = "사과";
	
	let apples = arr.filter((fr, index)=>{
		 return fr === item;  //fr를 리턴 
	})
	
	document.querySelector("#result5").innerHTML += apples;	
}

const proc6 = ()=>{
	const numbers = [9,4,1,3,7];
	
	/*let hap =0;
	numbers.forEach( (num, index) =>{
		hap += num
	})*/
	
	let hap = 0;
	hap  = numbers.reduce( (tot,num) =>{
		return  tot + num;  //hap로 리턴 
	}, 0);   //0은  tot의 초기값. 생략시배열의 0번재 값이 자동 초기화 
	
	let str = `${numbers}<br>`;
	str += `합 = ${hap}<br>`;
	
	document.querySelector("#result6").innerHTML = str;
	
	//최대값
	let max = numbers.reduce((acc, num)=>{
		 if(acc > num){
			 return acc;
		 }else {
			return num;
		 }
	}) //초기값 생략 - 배열의 0번째 값 9 로 acc변수를 초기화  
	document.querySelector("#result6").innerHTML += `최대값 = ${max} <br>`;
	
	//최소값 
	let min = numbers.reduce((acc, num)=>{
			 if(acc < num){
				 return acc;
			 }else {
				return num;
			 }
     });//초기값 생략 - 배열의 0번째 값 9 로 acc변수를 초기화 
	 
	 document.querySelector("#result6").innerHTML += `최소값 = ${min} <br>`;
}

const proc7 = () => {
	
	const fruits = ["APPLE", "BAnana", "CHErry"];
	const numbers = [1,2,3,4,5];
	
	//fruits 소문자변경
	let lower = fruits.map((fr, index) =>{
		  
		 return  fr.toLowerCase()
	})
	
	let str = `${fruits}<br>`
	str += `소문자변경 후 배열 : ${lower}<br>`
	
	document.querySelector("#result7").innerHTML = str; 

	//--------------------------------------------------//	
	//numbers * 2 를 수행해서 새로운 배열로 생성 해서 출력
	/*let nums = numbers.map( num =>{
		return num *2;
	})
	*/
	//function의 실행문이 한줄일때 축약 - { }, return , ; 를 생략 
	let nums = numbers.map(num => num * 2 )
	
	
	str = `${numbers}<br>`;
	str += `numbers *2 = ${nums}<br>`;
	document.querySelector("#result7").innerHTML += str; 
	
	/*const nums=[];
	//forEach문으로 수행시에는 새로운 베열을 선언 , push를 이용하여 저장한다
	numbers.forEach( num => {
		  nums.push(num * 2)
	})*/
	
	const birthYear = [1976,1997, 2002, 1995, 1985];
	//map을 이용해서 나이를 구한후 새로운 배열로 생성 해서 출력 
	
	/*let ages =birthYear.map( year =>{
		return  2025- year;
	}) */
	
	 let ages =birthYear.map( year =>  2025- year ) ;
	 
	 str = `${birthYear} <br>`
	 str += `나이 : ${ages}<br>`;
	 document.querySelector("#result7").innerHTML += str; 
	 	
}

const proc8 = () =>{
	
	const numbers = [40,54,67,58,30];
	
	//하나라도 조건을 만족하면 결과값은 true 
	let res = numbers.some( num=>{
		 return num >= 60;
	})
	
	let str = `${numbers}<br>`
	str += `some(조건>=60) : ${res}<br>`;
	if(res){
		str += "통과<br>";
	}else{
		str += "반납<br>";
	}
	
	document.querySelector("#result8").innerHTML = str; 
	
	//모든 값이 조건을 만족하면 결과값은 true
	res = numbers.every( num=> num >= 60)
	
	
	str = `every(조건>=60) : ${res}<br>`;
	
	if(res){
		str += "통과<br>";
	}else{
		str += "반납<br>";
	}
	
	document.querySelector("#result8").innerHTML += str; 
}























