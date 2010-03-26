<script>
        $.fck.config = {path: '/Cursos/js/inc/fckeditor/', height:200 }; 
		$('textarea#description').fck(); 	
		
		 $('#courseForm').ajaxForm({
		    success:function() { 		                
		                refreshCourses();
		                myLayout.open('west');
		                $("#cursosCenter").text("");
		            }
		            ,
		    error:function() { 
		               
		                alert("failure");
		            }   
		      }); 	
        </script>
        <div class="body"  style="width:100%; padding:0 0 0 0;margin:0 0 0 0;">
            <h1>Editar Curso</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${courseInstance}">
            <div class="errors">
                <g:renderErrors bean="${courseInstance}" as="list" />
            </div>
            </g:hasErrors>
            <form id="courseForm" action="<g:createLink controller='course' action='save'/>" method="post"  enctype="multipart/form-data">
                <g:hiddenField name="id" value="${courseInstance?.id}" />
                <g:hiddenField name="version" value="${courseInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="course.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${courseInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td colspan="2" valign="top" class="name">
                                  <label for="description"><g:message code="course.description.label" default="Description" /></label>
                                </td>
                                </tr>
                        
                            <tr class="prop">
                                <td  colspan="2" valign="top" class="value ${hasErrors(bean: courseInstance, field: 'description', 'errors')}">
                                    <textarea name="description" id="description">
                                    ${new String(courseInstance?.description)}
                                    </textarea>
                                </td>
                            </tr>
                                                    
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="course.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${User.list()}" optionKey="id" optionValue="name" value="${courseInstance?.user?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </form>
        </div>
