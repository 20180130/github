/*
 * the first time to call
 */
setTimeout(function(){
    Push();
//  alert("setTimeout called");
},200);

setInterval(function(){
    Push();
    //alert("setInterval called");
},3000);

function Push(){
    $.ajax({
        type:"POST",
        url:"/LoveBeHomeMis/CheckMessageFromDB?dt=" + new Date().getTime(),//why getTime and wont use
        data:{},
        beforeSend:function(){},
        success: function(data){
            var obj=eval("("+data+")");//eval使用前要先加括号，才能得到完整的json数据
            if(obj.msg!=0){

                $("#tongzhi-content").html(obj.msg);//更新提示内容中的数量部分
                $("#tongzhi").show();//消息提示内容，整个部分都显示出来
            }else{
                $("#tongzhi").hide();//隐藏整个提示消息部分
            }


        }
    });
}