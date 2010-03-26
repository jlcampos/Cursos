import org.w3c.dom.Document;import org.apache.commons.httpclient.HttpClient;import org.apache.commons.httpclient.HttpState;import org.apache.commons.httpclient.params.HttpClientParams;import com.google.code.facebookapi.FacebookException;import com.google.code.facebookapi.FacebookWebappHelper;import com.google.code.facebookapi.FacebookJsonRestClient;import com.google.code.facebookapi.IFacebookRestClient;import com.google.code.facebookapi.BasicClientHelper;import com.google.code.facebookapi.Permission;import my.god.fb.FBAppConstants; 
class CustomFilters {     
   def filters = {
        // your filters here
        
        loginCheck	(controller:'noexisto', action:'*') {
        	before = {
        			            			     IFacebookRestClient userClient = session.getAttribute(FBAppConstants.FACEBOOK_USER_CLIENT)        			     if(userClient == null){        			    	 userClient = new FacebookJsonRestClient(FBAppConstants.FB_API_KEY, FBAppConstants.FB_SECRET_KEY);        			    	 session.setAttribute(FBAppConstants.FACEBOOK_USER_CLIENT, userClient)        			     }						        		FacebookWebappHelper helper = new FacebookWebappHelper(request, response,         				FBAppConstants.FB_API_KEY, FBAppConstants.FB_SECRET_KEY, userClient);        		        		String nextPage = request.getRequestURI()	        	    nextPage = nextPage.substring(nextPage.indexOf("/", 1) + 1); //cut out the first /, the context path and the 2nd /        	 if(!helper.isLogin()){        	    boolean redirectOccurred = helper.requireLogin(nextPage);                if(redirectOccurred) {                        return;                }                redirectOccurred = helper.requireFrame(nextPage);                if(redirectOccurred) {                        return;                }        	 }                long facebookUserID;                try {                    facebookUserID = userClient.users_getLoggedInUser();                    Permission perm = Permission.STATUS_UPDATE;                    Permission perm2 = Permission.PUBLISH_STREAM;                    if ( !userClient.users_hasAppPermission(perm) ||                      		!userClient.users_hasAppPermission(perm2)) {            			// create http client            			HttpClient http = new HttpClient();            			http.setParams( new HttpClientParams() );            			http.setState( new HttpState() );            			// 'open' login popup/window            			Map params = new HashMap();            			params.put( "api_key", userClient.getApiKey() );            			params.put( "v", "1.0" );            			params.put( "fbconnect", "true" );            			params.put( "extern", "1" );            			params.put( "ext_perm", perm.getName() + "," + perm2.getName());            			params.put( "display", "popup" );            			params.put( "next", FBAppConstants.NEXT_URL );            			String queryString = BasicClientHelper.delimit( params.entrySet(), "&", "=", true ).toString();            			String url = FBAppConstants.PERM_BASE_URL + "?" + queryString;            			redirect(url:url );            			            		}                } catch(FacebookException ex) {                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error while fetching user's facebook ID");                    logger.error("Error while getting cached (supplied by request params) value " +                                     "of the user's facebook ID or while fetching it from the Facebook service " +                                     "if the cached value was not present for some reason. Cached value = {}", userClient.getCacheUserId());                    return;                }        	}
        	
        }
   }    
}