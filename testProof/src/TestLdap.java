
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.ldap.core.support.LdapContextSource;
import org.springframework.security.ldap.SpringSecurityAuthenticationSource;


public class TestLdap {

	/**
	 * @param args
	 */
	static LdapTemplate ldapTemplate = null;
	public static void main(String[] args) {
		
		if (!loginLDAP("admin", "spr")){  // User ID  and Application ID hard coded
			System.out.println("false");
		} else {
			System.out.println("true");
		}
	
	}
	public static boolean loginLDAP (String userId, String applicationId) {
		String password = "password"; // Password Hard coded
		if (getLdapTemplate(applicationId) == null) return false;
		if (!(ldapTemplate.authenticate("", "(uid=" + userId + ")", password))){
			System.out.println("authenticate block***");
			return false;
		}
		return true;
	}
	
	public static LdapTemplate getLdapTemplate(String applicationId) {
		if (ldapTemplate == null) {
			try {
				/*Properties properties = dbConPool.getConf(ArrayLIMSConfigConstants.APP_PROPERTY_FILE_NAME);
				if (properties == null) return null; // cannot login without finding conf file
*/				
				String uri = "ldap://ldap.gene.com:389";  // Ldap uri
				String base = "ou=people,dc=gene,dc=com";

				LdapContextSource contextSource = new LdapContextSource(); // note: reading LDAP address from conf file can be a minimal threat, but taking that risk for now.
				contextSource.setUrl(uri);
				contextSource.setBase(base);
				contextSource.setAuthenticationSource(new SpringSecurityAuthenticationSource());
				contextSource.afterPropertiesSet();
				ldapTemplate = new LdapTemplate(contextSource);
			} catch (Exception e) {
				return null;
			}
		}
		return ldapTemplate;
	}

}
