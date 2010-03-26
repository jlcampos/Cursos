               <jq:jquery>
               //$("#documentHTML").jScrollPane({scrollbarWidth:10, scrollbarMargin:10});
        $.fck.config = {path: '/Cursos/js/inc/fckeditor/', height:400 }; 
		$('textarea#html').fck(); 	
		
		 $('#docsForm').ajaxForm({
		    success:function(r,s,x,j) {
		    refreshDocuments($(j).children("input[name=course.id]")[0].value)		    		    			 		               		                
		                myLayout.open('east');
		                $("#cursosCenter").text("");
		            }
		            ,
		    error:function() { 
		               
		                alert("failure");
		            }    
		            
		      }); 	
        </jq:jquery>
       
       
       <div class="body" style="width:100%; padding:0 0 0 0;margin:0 0 0 0;">
            <h1>Crear Documento</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${documentInstance}">
            <div class="errors">
                <g:renderErrors bean="${documentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <form id="docsForm" action="<g:createLink controller='document' action='save'/>" method="post"  enctype="multipart/form-data">
            <input type="hidden" name="course.id" value="${params.id}"  />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="document.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${documentInstance?.name}" />
                                </td>
                            </tr>
                                                   
                            <tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                    <label for="html"><g:message code="document.html.label" default="Html" /></label>
                                </td>
                             </tr>
                             <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean: documentInstance, field: 'html', 'errors')}">
                                <div id="documentHTML">                                
                                    <textarea name="html" id="html"></textarea> 
                                    </div>                               
                                </td>
                            </tr>
                        
                        
                        </tbody>
                    </table>
                </div>
                
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </form>                
        </div>