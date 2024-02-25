package api;

import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

//네이버 SMTP 서버를 통해 이메일을 전송하는 클래스
public class MailSender {
	private final Properties serverInfo; // 서버 정보
	private final Authenticator auth; // 인증 정보

	public MailSender() {
		// 네이버 SMTP 서버 접속 정보
		serverInfo = new Properties();
		serverInfo.put("mail.smtp.host", "smtp.naver.com");
		serverInfo.put("mail.smtp.port", "465");
		serverInfo.put("mail.smtp.starttls.enable", "true");
		serverInfo.put("mail.smtp.auth", "true");
		serverInfo.put("mail.smtp.debug", "true");
		serverInfo.put("mail.smtp.socketFactory.port", "465");
		serverInfo.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		serverInfo.put("mail.smtp.socketFactory.fallback", "false");
     
     	// 네이버 서버와 ssl 통신이 되지 않을 경우 추가
		serverInfo.put("mail.smtp.ssl.protocols", "TLSv1.2");

		// 사용자 인증 정보
		auth = new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("rkwkalrms777@naver.com", "alsgmlsmsaht34#$");
			}
		};
	}

	// 주어진 메일 내용을 네이버 SMTP 서버를 통해 전송
	public void emailSending(String from, String to, String subject, String content) throws MessagingException {
		// 1. 세션 생성
		Session session = Session.getInstance(serverInfo, auth);
		session.setDebug(true);

		// 2. 메시지 작성
		MimeMessage msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress(from)); // 보내는 사람
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to)); // 받는 사람
		msg.setSubject(subject); // 제목
		msg.setContent(content, "text/plain;charset=UTF-8"); // 내용

		// 3. 전송
		Transport.send(msg);
	}
	//필요한 곳에 객체 생성해서 내가 사용하면 된다.
	public static void main(String[] args) {
		try {
		    MailSender smtpServer = new MailSender(); 
		    smtpServer.emailSending("rkwkalrms777@naver.com", "rkwkalrms777@naver.com", "제목", "내용 ㅎㅎㅎ 가자미군");  // 전송
		    System.out.println("이메일 전송 성공");
		}
		catch (Exception e) {
		    System.out.println("이메일 전송 실패");
		    e.printStackTrace();
		}
	}
}
