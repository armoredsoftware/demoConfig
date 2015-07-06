<?php
/*  File:        main.php
*   Author:      Justin Dawson (JDawson@ku.edu)
*   Description: Main Demo Page. Two basic types of UI areas: User Request and
*                Appraiser/Attester views. The User Request area is an area where
*                the user can send information to the Appraiser that will be
*                forwarded to the Appraiser. The Appraiser/Attester Views allow
*                the user to select which VM will be an Appraiser or Attester
*                and displays a log of that VM.
*/
  include('session.php');
?>
<!DOCTYPE html>
<html>
<head>
   <script src="http://code.jquery.com/jquery-latest.min.js"
        type="text/javascript"></script>
   <link rel="stylesheet" type="text/css" href="css/armored.css">
</head>

<script>
var nAttesters = 1;
var _cancelled = 0;
function computeNodeChange(){
  _cancelled = 1;
  var node = $(this).val();
  var that = $(this).parent();
  var num = $(this).attr("id").replace("attester");
  $(that).children('textarea').val("");                                         
  if ( node == ""){
    return;
    
  }
  
  $("#global_loading").show();
  $.ajax({method:"POST",
         url:"nodeStatus.php",
         data:{node:node},
         success:function(data){
            $("#global_loading").hide();
            data = data.replace(/ +\t*/g,"\t");
            var arr = data.slice(3,data.length -2).split("\n");
            if ( data.length <= 4){
               arr.pop();
            } 
            var list = "<table><th></th><th>ID</th><th>Name</th></table>";
             
            $(that).children(".vms").empty();
            $(arr).each(function(){
                var v = '<tr></tr>';                                             
                var vm = this.split("\t");
                vm[2] = vm[2].trim();
                v = $(v).append('<td title="'+vm[2]+'"><input type="radio" name="'+
                      num+'" data-ip="'+vm[2]+'"/></td><td title="'+vm[2]+'">'+ vm[1]+
	   	      '</td><td title="'+vm[2]+'">'+vm[0]+'</td><br/>');
                list=$(list).append(v);
	    });
                                                        
	    if (arr.length > 0){
                var button = '<button id="'+num+'Cancel">Stop</button>';
	        $(that).children(".vms").append(list);
                $(that).children(".vms").append(button);
                $("#"+num+"Cancel").click(stopFunc);
	    }else{
	        $(that).children(".vms").append("<p>None</p>");
	    }
            var minH = $(that).css("min-height").replace(/px/,"");
            if ( minH < $(that).height()){
               $(".logDiv").css("min-height",$(that).height());
            }
                
         }
  });      
}

function stopFunc(){
    _cancelled = 1;
   
}

function textAreaSetup(){

   $("#protocol").click(function(){
     if($("#protocol").val() == "Enter Request"){
        $("#protocol").val(""); 
        $("#protocol").css("color","black");
     }
   });
   $("#protocol").focusout(function(){
        if ($(this).val() == ""){
          $("#protocol").val("Enter Request");
          $("#protocol").css("color","gray");
        }
     }
    );
}
function requestChange(){
    var type = $(this).val();
    var $params = $("#requestParams");

    if (type == "Select Type"){
        $params.empty();
	$("#submit").prop("disabled",true);
         return;
    }
      $("#submit").prop("disabled",false);
    if (type == "Protocol Number"){
      
      $params.empty();
      $params.append('<div class="param"><label>Number</label>'
                     +'<input class="val" type="number" name="protNumber" id="protNumber"'
		     +'min="1" max="100" step="1" value="1"/> </div>');
    }else if (type == "Request Item"){
      $params.empty();
      $params.append(
         '<div class="param"><label style="padding-right:74px;">Item</label>'
        +'<select class="val">'
          +'<option>OS</option>'
          +'<option>VirusChecker</option>'
        +'</select></div>'
        +'<br/>'
        +'<div class="param"><label style="padding-right:48px;">Property</label>'
        +'<select class="val">'
          +'<option>Name</option>'
          +'<option>Version</option>'
        +'</select></div>'
      );

    }else if (type =="Request List"){
      $params.empty();
      $params.append('<textarea id="protocol" rows="25" cols="30" >Enter Request</textarea>');
      textAreaSetup();
    }else if (type == "Other"){
        $params.empty();
        $params.append('<textarea id="protocol" rows="25" cols="30" >Enter Request</textarea>');
        textAreaSetup();
    }
}

function textareaSend(ip){
var proto = $("#protocol").val();
      if ( proto == "Enter Request"){
        return;
      }

      $.ajax({method:"POST",
              url:"send.php",
              data:{ip:ip,data:"request="+proto},
              success:function(data){
                 $("#global_loading").hide();
                 $("#appLog").val(data);
              }
       });

}

function buildData(){
      var str='';
      var items = $("#requestParams").find(".param");
       for ( var i =0; i < items.length; i++){
          var elem = items[i];
          var lab = $(elem).find("label").text();
          var val = $(elem).find(".val").val() ;
             str+=',';
          if ( lab =="Number"){
             str+='"Num":'+val;
          }else{
             if ( val == "VirusChecker"){
                str+='"'+lab+'":{"VC":"'+lab+'"}';
             }else{
                str+='"'+lab+'":{"'+val+'":"'+lab+'"}';
             }   
          }
       }      
       return str;
    }

function preprocessReqType(){
    var rType = $("#requestType").val();
    if(rType=="Request Item"){
        rType ="RequestItem";
    }else if(rType=="Protocol Number"){
        rType="ProtoNum";
    }else if (rType=="Other"){
    }else{
      rType="INVALID";
    }
  return rType;
}
function buttonSetup(){
   //Add Attester Button
    $("#addAttester").click(function(){
       nAttesters++;
           
       var elem = '<div id="attester'+nAttesters+'" class="logDiv"></div>';
       $("#workspace").append(elem);
       $.get("attester.html", function (data){
            $("#attester"+nAttesters).html(data.replace(/{{ id }}/g,nAttesters));
            $("#attester"+nAttesters).children(".x").click(function(){
               $(this).parent().remove();
             });
            $("#attester"+nAttesters).find("#computeNode"+nAttesters).change(computeNodeChange);
        });
       $("#attester"+nAttesters).hover(function(){
                                          $(this).children(".x").show();},
                                       function(){
                                            $(this).children(".x").hide();
                                       });
    });

    $("#submit").click(function (){
       $("#global_loading").show();
       _cancelled= 1;
    //   var data = $("#protocol").val();
       var app = $("#appNode").siblings(".vms").find("input:checked"); 
       var appIp = app.data("ip"); 
       var att = $("#computeNode1").siblings(".vms").find("input:checked");
       var attIp = att.data("ip");
 
       if ( app.length == 0){
          alert("Select an Appraiser");
          $("#global_loading").hide();
          return;
       } 
       if ( att.length == 0){
          alert("Select an Attester");
          $("#global_loading").hide();
          return;
       } 
     
       var rType = preprocessReqType();

       if (rType=="Other"){
           textareaSend(appIp);
           return;
       }else if(rType=="INVALID"){
           alert("Invalid Request Type");
       }
       

       var data = '{"NRequest":{"';

       if ( $("#requestList").prop("checked")){
         data+='ReqLS":"NRequest","Requests":[';
         var items = $("#protocol").val().split("\n");
          for (var i = 0; i < items.length; i++){
             if ( i != items.length -1){
                data += items[i]; 
             }
             if ( i < items.length -2){
                data +=",";
             }
             
          }
          data+=']';
       }else{
        data+=rType+'":"NRequest"'+buildData();
       }
       data+='},' +'"Entity":{"EntityName":"Attester", "EntityRole":"Attester","EntityIp":"'+btoa(attIp)+'"'
       +', "EntityNote":null, "EntityId":null}}';
       
       console.log(data);
       $.ajax({method:"POST",
               url:"send.php",
               data:{ip:appIp,data:"request="+data},
               success:function(data){
                  $("#global_loading").hide();
                  $("#appLog").val(data);
                  console.log(data);
               }
       });
          setTimeout(function(){
          _cancelled= 0;
          readLog($("#appNode"));
          readLog($("#computeNode1"));
                  },300);
    });
}

function readLog(elem){
    var ip = ($(elem).siblings(".vms").find("input:checked").data("ip"));
    $.ajax({method:"POST",
            url:"readLog.php",
            data:{ip:ip},
	    success:function(data){
              var textBox = $(elem).siblings("textarea");
              var old = textBox.val();
              textBox.val(data);
              if (textBox.val() != old){
                textBox.scrollTop(textBox[0].scrollHeight - textBox.height());
              }
	    }
    });
    if ( !_cancelled){
       setTimeout(function(){
       },300);
    }
}   

function start(){

  

   $("#header").load("header.html", function(){
       $("#logout").click(function(){
          $.ajax({method:"POST",
               url:"logout.php",
               success:function(){
                  window.location="index.php";
               }
          });
       });
      
     });
   //text area functions
    textAreaSetup();
 
   //send button
    buttonSetup();

   //Compute node selection
   $("#computeNode").change(function(){
      var node = $(this).val();
      if (node == ""){
         return;
      }
      $("#global_loading").show();
      $.ajax({method:"POST",
              url:"nodeStatus.php",
              data:{node:node},
              success:function(data){
                $("#global_loading").hide();
                var arr = data.split("\n");
                arr = arr.slice(0,arr.length-1);
                var list = $("<ul></ul>");
                $("#status").empty();
                $("#status").append("<h4>VMs running:</h4>"); 
                $(arr).each(function(){
                   list.append("<li>"+this+"</li>");
                 });
                if (arr.length > 0){
                  $("#status").append(list);
                }else{
                  $("#status").append("<p>None</p>");
                }
                
              }
      });      
    });  
    $("#appNode").change(computeNodeChange);
    $("#computeNode1").change(computeNodeChange);
    $("#requestType").change(requestChange);

    $("#appNode").change();
    $("#computeNode1").change();
    $("#requestType").change();
      
    $("#requestList").click(function(){
          var x = $("#requestType").children();
          if ( $("#requestType").val() == "Other"){
               $("#requestType").val("Select Type");
               $("#requestType").change();
          } 
          for( var i = 0; i < x.length; i++){
              if ($(x[i]).val() == "Other"){
                if ( $(this).prop("checked")){
                   $(x[i]).hide();
                }else{
                   $(x[i]).show();
                }
              }
          }
          if ($(this).prop("checked")){
             $("#reqListOut").append('<button id="add">Add</button><br/>');
             $("#reqListOut").append('<textarea id="protocol" rows="25" cols="30" >Enter Request</textarea>');
             textAreaSetup();

             $("#add").click(function(){
                  var rtype = preprocessReqType();
                  if (rtype=="INVALID" || rtype=="OTHER"){
                    alert("Invalid request Type");
                    return;
                  }
                  var s = '{"'+rtype+'":"NRequest"'
                  s+=buildData()+"}";
                 var v= $("#protocol").val();
                 if (v == "Enter Request"){
                    v = "";
                 }
                 $("#protocol").val(v+s+"\n");
             });
          }else{
             $("#reqListOut").empty();
          }
     });

}

 window.onload=start;
</script>
<body>
<div id="header">
</div>

<div id="global_loading">
<img src="images/loading.gif"/>
</div>
<div id="workspace">
   <div class="logDiv" style>
      <h3>User Request</h3>
      <label>Request List</label>
      <input id="requestList" type="checkbox" />
      <br/>
      <br/>
      <label>Request Type: </label>
      <select id="requestType">
              
         <option>Select Type</option>
         <option>Protocol Number</option>
         <option>Request Item</option>
         <option>Other</option>
      </select>
         <br/>
      <div id="requestParams">
      <!--   <textarea id="protocol" rows="25" cols="30" >Enter Request</textarea>
         -->
      </div>
      <br />
      <div id="reqListOut">
      </div>
         <p id="status"></p>
	 <button id="submit" disabled>Send Request</button>
   </div>

   <div class="logDiv">
      <h3 class="title">Appraiser</h3>
      <label>Select a Compute Node: </label>
      <select id="appNode">
        <option></option>
        <option>1</option>
        <option>2</option>
        <option>3</option>
        <option>4</option>
        <option>5</option>
        <option>6</option>
        <option>7</option>
        <option>8</option>
      </select>
      <div class="vms"></div>
      <h4>Log</h4>
      <textarea id="appLog" rows="22" cols="30" style="resize:none;" disabled="disabled">
      </textarea>
   </div>

   <div class="logDiv">
      <h3 class="title"> Attester</h3>
      <label>Select a Compute Node: </label>
      <select id="computeNode1">
        <option></option>
        <option>1</option>
        <option>2</option>
        <option>3</option>
        <option>4</option>
        <option>5</option>
        <option>6</option>
        <option>7</option>
        <option>8</option>
      </select>

      <div class="vms"></div>
      <h4>Log</h4>
      <textarea id="attLog" rows="22" cols="30" style="resize:none;" disabled="disabled">
      </textarea>
   </div>
</div>
<div>
   <img id="addAttester" src="images/plus.png" width="50px"/>
</div>


</body>

</html>
