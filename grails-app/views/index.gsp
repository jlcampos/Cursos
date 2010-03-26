<html>
    <head>
        <title>Welcome to MyVersion</title>
		<meta name="layout" content="main" />
		
		<style type="text/css">
	/**
	 *	Basic Layout Theme
	 * 
	 *	This theme uses the default layout class-names for all classes
	 *	Add any 'custom class-names', from options: paneClass, resizerClass, togglerClass
	 */
	.pane,
	.ui-layout-pane { /* all 'panes' */ 
		background: #FFF; 
		border: 1px solid #BBB; 
		padding: 10px; 
		overflow: auto;
	} 
	
	.ui-selected {
		background-color: #F6A828; 
		
	} 

	.resizer,
	.ui-layout-resizer { /* all 'resizer-bars' */ 
		background: #DDD; 
	} 

	.toggler,
	.ui-layout-toggler { /* all 'toggler-buttons' */ 
		background: #AAA; 
	} 


	.course-element,
	.document-element
	{
		border:2px ridge #eaeaea ;			
		float: left; font-size: 1.2em; width: 100%; text-align: center; 
		
		}
		.innerLeft {
		float:left;
		width:90%;
			
		}
		.innerRight {
		float:left;
		width:10%;		
		}
		
		
		
		#sortableCourses:after{
			content:' ';
			display:block;
			clear:both;
		}
		
		#sortableCourses { list-style-type: none;word-wrap: break-word;}
		
		#sortableCourses .ui-selecting { background: #FECA40; }
	#sortableCourses .ui-selected { background: #F39814; color: white; }
	#sortableCourses { list-style-type: none; margin: 0; padding: 0; }
	#sortableCourses li { margin: 3px; padding: 0.4em; font-size: 1.4em; height: 18px; }
	
	#sortableDocuments { list-style-type: none;word-wrap: break-word;}
		
		#sortableDocuments .ui-selecting { background: #FECA40; }
	#sortableDocuments .ui-selected { background: #F39814; color: white; }
	#sortableDocuments { list-style-type: none; margin: 0; padding: 0; width:100%; height:280px;}
	#sortableDocuments li { margin: 3px; padding: 0.4em; font-size: 1.4em; height: 18px; }

	#courseInfo {background: #F39814; color: white; width:100%;}
	#courseDesc {background: #fff; color: black; width:100%; height:50px;}
	.jScrollPaneContainer{	
	 border: 1px solid lightgray;
	}
/*
 *	extJS-STYLE TOGGLE & PIN BUTTONS
 *
 *	these 'extra buttons' are INSIDE the east/west panes
 */

/* CUSTOM pin/close buttons */
span.button-pin ,
span.button-close {
	position:	absolute;
	top:		0;
	width: 		20px;
	height:		20px;
	z-index:	2;
	display:	block;
	cursor: 	pointer;
}
span.button-close-west	{ left:	 0; }
span.button-close-east	{ right: 0; }
span.button-pin-west	{ right: 1px; }
span.button-pin-east	{ left:	 1px; }

/* CUSTOM pin-buttons */
span.button-pin-up 		  		{ background: url(images/pin-up-off.gif) no-repeat center; }
span.button-pin-up:hover   		{ background: url(images/pin-up-on.gif)  no-repeat center; }
span.button-pin-down 	  		{ background: url(images/pin-dn-off.gif) no-repeat center; }
span.button-pin-down:hover 		{ background: url(images/pin-dn-on.gif)  no-repeat center; }


/* STANDARD toggler-buttons - when the east/west panes are 'closed' */
.toggler-west-closed		{ background: url(images/go-rt-off.gif) no-repeat center; }
.toggler-west-closed:hover	{ background: url(images/go-rt-on.gif)  no-repeat center; }
.toggler-east-closed		{ background: url(images/go-lt-off.gif) no-repeat center; }
.toggler-east-closed:hover	{ background: url(images/go-lt-on.gif)  no-repeat center; }



/*
*	GENERAL COSMETICS
*/

/*
*	COMMON LAYOUT PANE FORMATTING
*/


/*
*	OUTER-LAYOUT PANE FORMATTING
*/
.pane-north ,
.pane-south ,
.pane-west ,
.pane-east {
	overflow:		hidden;
}
.pane-north {	
	}
	.pane-north .content ,
	.pane-south .content {
		text-align: center;
	}
.pane-center {
	/* show off the inner-layout inside the outer-center-pane*/
	background-color: #F6F6F6;
	padding: 15px; /* for outer layout */
}

	</style>
    </head>
    <body>
	<jq:jquery>
		 $("#mainContainer").tabs();
		 
		 $.ajaxSetup({
			  beforeSend: function() {
			     $('#spinner').show();
			  },
			  complete: function(){
			     $('#spinner').hide();
			  },
			  success: function() {
			  $('#spinner').hide();
			  }
			});
			
		 var layoutSettings_Outer = {
		name: "outerLayout" // NO FUNCTIONAL USE, but could be used by custom code to 'identify' a layout
		// options.defaults apply to ALL PANES - but overridden by pane-specific settings
	,	defaults: {
			size:					"auto"
		,	minSize:				50
		,	paneClass:				"pane" 		// default = 'ui-layout-pane'
		,	resizerClass:			"resizer"	// default = 'ui-layout-resizer'
		,	togglerClass:			"toggler"	// default = 'ui-layout-toggler'
		,	buttonClass:			"button"	// default = 'ui-layout-button'
		,	contentSelector:		".content"	// inner div to auto-size so only it scrolls, not the entire pane!
		,	contentIgnoreSelector:	"span"		// 'paneSelector' for content to 'ignore' when measuring room for content
		,	togglerLength_open:		35			// WIDTH of toggler on north/south edges - HEIGHT on east/west edges
		,	togglerLength_closed:	35			// "100%" OR -1 = full height
		,	hideTogglerOnSlide:		true		// hide the toggler when pane is 'slid open'
		,	togglerTip_open:		"Close This Pane"
		,	togglerTip_closed:		"Open This Pane"
		,	resizerTip:				"Resize This Pane"
		//	effect defaults - overridden on some panes
		,	fxName:					"slide"		// none, slide, drop, scale
		,	fxSpeed_open:			750
		,	fxSpeed_close:			1500
		,	fxSettings_open:		{ easing: "easeInQuint" }
		,	fxSettings_close:		{ easing: "easeOutQuint" }
	}
	,	north: {
			spacing_open:			1			// cosmetic spacing
		,	togglerLength_open:		0			// HIDE the toggler button
		,	togglerLength_closed:	-1			// "100%" OR -1 = full width of pane
		,	resizable: 				false
		,	slidable:				false
		//	override default effect
		,	fxName:					"none"
		}
	,	south: {
			maxSize:				200
		,	spacing_closed:			0			// HIDE resizer & toggler when 'closed'
		,	slidable:				false		// REFERENCE - cannot slide if spacing_closed = 0
		,	initClosed:				true
		//	CALLBACK TESTING...
		,	onhide_start:			function () { return confirm("START South pane hide \n\n onhide_start callback \n\n Allow pane to hide?"); }
		,	onhide_end:				function () { alert("END South pane hide \n\n onhide_end callback"); }
		,	onshow_start:			function () { return confirm("START South pane show \n\n onshow_start callback \n\n Allow pane to show?"); }
		,	onshow_end:				function () { alert("END South pane show \n\n onshow_end callback"); }
		,	onopen_start:			function () { return confirm("START South pane open \n\n onopen_start callback \n\n Allow pane to open?"); }
		,	onopen_end:				function () { alert("END South pane open \n\n onopen_end callback"); }
		,	onclose_start:			function () { return confirm("START South pane close \n\n onclose_start callback \n\n Allow pane to close?"); }
		,	onclose_end:			function () { alert("END South pane close \n\n onclose_end callback"); }
		//,	onresize_start:			function () { return confirm("START South pane resize \n\n onresize_start callback \n\n Allow pane to be resized?)"); }
		,	onresize_end:			function () { alert("END South pane resize \n\n onresize_end callback \n\n NOTE: onresize_start event was skipped."); }
		}
	,	west: {
			size:					250
		,	spacing_closed:			21			// wider space when closed
		,	togglerLength_closed:	21			// make toggler 'square' - 21x21
		,	togglerAlign_closed:	"top"		// align to top of resizer
		,	togglerLength_open:		0			// NONE - using custom togglers INSIDE west-pane
		,	togglerTip_open:		"Close West Pane"
		,	togglerTip_closed:		"Open West Pane"
		,	resizerTip_open:		"Resize West Pane"
		,	slideTrigger_open:		"mouseover" 	// default
		,	initClosed:				true
		,	fxName:					"drop"
		,	fxSpeed:				"normal"		
		,	fxSettings_open:		{ easing: "" }
		}
	,	east: {
			size:					250
		,	spacing_closed:			21			// wider space when closed
		,	togglerLength_closed:	21			// make toggler 'square' - 21x21
		,	togglerAlign_closed:	"top"		// align to top of resizer
		,	togglerLength_open:		0 			// NONE - using custom togglers INSIDE east-pane
		,	togglerTip_open:		"Close East Pane"
		,	togglerTip_closed:		"Open East Pane"
		,	resizerTip_open:		"Resize East Pane"
		,	slideTrigger_open:		"mouseover"
		,	initClosed:				true
		,	fxName:					"drop"
		,	fxSpeed:				"normal"
		,	fxSettings:				{ easing: "" } // nullify default easing
		}
	,	center: {
			paneSelector:			"#mainContent" 			// sample: use an ID to select pane instead of a class
		,	onresize:				"innerLayout.resizeAll"	// resize INNER LAYOUT when center pane resizes
		,	minWidth:				200
		,	minHeight:				200
		}
	};
		 
		 myLayout = $('#section-1').layout(layoutSettings_Outer);
		 
		 		
		 // save selector strings to vars so we don't have to repeat it
		// must prefix paneClass with "body > " to target ONLY the myLayout panes
		var westSelector = "#section-1 > .ui-layout-west"; // outer-west pane
		var eastSelector = "#section-1 > .ui-layout-east"; // outer-east pane
		 
		 $("<span></span>").addClass("pin-button").prependTo( westSelector );
		$("<span></span>").addClass("pin-button").prependTo( eastSelector );
		
		// BIND events to pin-buttons to make them functional
		myLayout.addPinBtn( westSelector +" .pin-button", "west");
		myLayout.addPinBtn( eastSelector +" .pin-button", "east" );
		 
	   
		createCourse = function() { 		
		myLayout.close('west');
		myLayout.close('east');
		$("#cursosCenter").load('course/mycreate.gsp');		
		}
		
		createDocument = function(id) { 		
		myLayout.close('west');
		myLayout.close('east');
		$("#cursosCenter").load('document/mycreate.gsp',{id:id});		
		} 
		
		editCourse = function(id) { 
		myLayout.close('west');
		myLayout.close('east');
		$("#cursosCenter").load('course/myedit',{id:id});
		}   
		
		editDocument = function(id) { 
		myLayout.close('east');
		myLayout.close('east');
		$("#cursosCenter").load('document/myedit',{id:id});
		}  
		   
		refreshCourses = function() { 
		 $("#sortableCourses ").text("");
		   $.ajax({
			  url: '<g:createLink controller="course" action="listJSON"/>',
			  success: function(data) {			    
			    
			    jQuery.each(data, function(index, value) {
			    
					$("<div class='course-element'><input type='hidden' name='course' value='" + value.id + "'/><div class='innerLeft'>" + value.name + 
					"</div><div class='innerRight'><a href='javascript:editCourse(" + value.id +")'><img class='imgBtn' border='0' src='images/skin/database_edit.png' style='cursor: pointer; display: inline;'></a>" +
					"<a  href='javascript:deleteCourse(" + value.id +")'><img class='imgBtn' border='0' src='images/skin/database_delete.png' style='cursor: pointer; display: inline;'></a></div></div>")
					.appendTo("#sortableCourses");  					
					});
								    
			  }
			});		
		}
		
		refreshDocuments = function(id) { 
		 $("#sortableDocuments").text("");
		 $("#courseInfo").text("");				 	
		   $.ajax({
			  url: '<g:createLink controller="course" action="getJSON"/>',
			  data:{id:id},
			  success: function(data) {		
			  	 $("#courseId").text("");
			  	 $("#courseInfo").text("");
			  	 $("#sortableDocuments").text("");   
			  var desc = "";
			  
			    jQuery.each(data.course.description, function(index, value) {
			    desc += String.fromCharCode(value);
			    });
			    
			    $("<a  href='javascript:createDocument(" + data.course.id+")'><img  border='0' src='images/skin/database_add.png' style='cursor: pointer; display: inline;'></a>")
			    .appendTo("#courseId");
			    $("<table border=0 cellspacing='0px' cellpadding='0px'><tr><td>Curso:</td><td>"+ data.course.name + "</td></tr>" +
			    "<tr><td colspan='2'>Descripci&oacute;n:</td></tr><tr><td colspan='2'><div id='courseDesc'>"+ desc + "</div></td></tr>" + 
			    "</table>").appendTo("#courseInfo");

			    $("#courseDesc").jScrollPane({scrollbarWidth:10, scrollbarMargin:0});
			    
			    jQuery.each(data.documents, function(index, value) {
			    
					$("<div class='document-element'><input type='hidden' name='document' value='" + value.id + "'/><div class='innerLeft'>" + value.name + "<br/><img border=1 src='images/" +value.course.id+"/" +value.id+"/image110x110.png'/>" + 
					"</div><div class='innerRight'><a href='javascript:editDocument(" + value.id +","+ value.course.id +")'><img class='imgBtn' border='0' src='images/skin/database_edit.png' style='cursor: pointer; display: inline;'></a>" +
					"<a  href='javascript:deleteDocument(" + value.id +","+ value.course.id + ")'><img  class='imgBtn' border='0' src='images/skin/database_delete.png' style='cursor: pointer; display: inline;'></a></div></div>")
					.appendTo("#sortableDocuments");  					
					});
				
				$("#sortableDocuments").jScrollPane({scrollbarWidth:10, scrollbarMargin:0});				    
			  }
			});		
			
			
		}
		
		
		deleteCourse = function(id) { 		
		$.ajax({
			  type: 'POST',		
			  url: '<g:createLink controller="course" action="delete"/>?id=' + id,
			  success: function(data) {	
			  refreshCourses();
			  $("#cursosCenter").text("");			    				    
			  }
			});			 	
		}
		
		deleteDocument = function(id, courseid) { 		
		$.ajax({
			  type: 'POST',		
			  url: '<g:createLink controller="document" action="delete"/>?id=' + id,
			  success: function(data) {	
			  refreshDocuments(courseid);
			  $("#cursosCenter").text("");			    				    
			  }
			});			 	
		}
		
		$("#sortableCourses")
				.selectable({
					autoRefresh: false,
					filter: 'div.course-element',
					start: function(e,ui){
						$(this).selectable( 'refresh');
					},
					 cancel: 'a,img.imgBtn',
					  selected: function(event, ui) {
					  var hidden = $(ui.selected).children("input")[0];
					  refreshDocuments(hidden.value);
					  myLayout.open('east');
					 
					 }					 
				})	
					
				/*.sortable({
					opacity:'0.5',
					cursor: 'move',
					zIndex: 5,
					helper : 'clone',
					forcePlaceholderSize : true,
					stop : function(event, ui){
						$("#sortableCourses").selectable( 'refresh');						
					}				 	
				})
				*/
				
				$("#sortableDocuments")
				.selectable({
					autoRefresh: false,
					filter: 'div.document-element',
					start: function(e,ui){
						$(this).selectable( 'refresh');
					},
					 cancel: 'a,img.imgBtn',
					  selected: function(event, ui) {
					 
					 
					 }					 
				})
								
				
		refreshCourses();
									
		myLayout.open('west');
		
      	</jq:jquery>     
      	   	
	<div id="mainContainer">
	    <ul>
	        <li><a href="#section-1">Mis Cursos</a></li>
	        <li><a href="#section-2">Cursos de Mis Amigos</a></li>
	        <li><a href="#section-3">Cursos en Progreso</a></li>
	    </ul>
	<div id="section-1" style="height:500px;">
	        <div class="ui-layout-north">
			<div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        	</div> 
			</div>

			<!-- allowOverflow auto-attached by option: west__showOverflowOnHover = true -->
			<div class="ui-layout-west">			
				<div class="innerLeft">
				<h2>Mis Cursos</h2>		
				</div>
				<br/>
				<div class="innerRight">		
				<a  href='javascript:createCourse()'><img  border='0' src='images/skin/database_add.png' style='cursor: pointer; display: inline;'>
				</a>
				</div>				
			
			<div id="sortableCourses" class="connectedSortable"> 
			
			</div>
			</div>
			
			<div class="ui-layout-south">
				This is the south pane, closable, slidable and resizable &nbsp;
				<button onclick="myLayout.toggle('north')">Toggle North Pane</button>
			</div>
			
			<div class="ui-layout-east">			
			<div class="innerLeft">
			<h2>&nbsp;&nbsp;Documentos del Curso</h2>
			</div>	
			<br/>
			<div id="courseId" class="innerRight">
			
			</div>	
			<br/>		
			<div id="courseInfo" style="float:left;">											
			</div>	
						
			<div id="sortableDocuments" class="connectedSortable"> 			
			</div>
			</div>
			
			<div id="mainContent">
			<div id="cursosCenter" class="ui-layout-center">
				
			</div>
			</div>
			
	    </div>
	    <div id="section-2">
	       Seccion 2
	    </div>
	    <div id="section-3">
	        Seccion 3
	    </div>
	</div>
		    
		    
	</body>
</html>