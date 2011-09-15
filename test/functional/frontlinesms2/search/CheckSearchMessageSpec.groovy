package frontlinesms2.search

import frontlinesms2.*

class CheckSearchMessageSpec extends SearchGebSpec {
	
	def "header checkbox is checked when all the messages are checked"() {
		given:
			createInboxTestMessages()
		when:
			to SearchPage
			messagesSelect[1].click()
			messagesSelect[2].click()
			messagesSelect[3].click()
		then:
			waitFor { messagesSelect[0].@checked == "true" }
	}
	
	def "message count displayed when multiple messages are selected"() {
		given:
			createInboxTestMessages()
		when:
			to SearchPage
			messagesSelect[1].click()
			messagesSelect[2].click()
		then:
			waitFor { checkedMessageCountText == "2 messages selected" }
	}
	
	def "checked message details are displayed when message is checked"() {
		given:
			createInboxTestMessages()
		when:
			to SearchPage
			messagesSelect[2].click()
		then:
			waitFor { $("#message-details #contact-name").text() == $(".displayName-${Fmessage.findBySrc('Bob').id}").text() }
		
		when:
			messagesSelect[1].click()
		then:
			waitFor { $("tr#message-${Fmessage.list()[0].id}").hasClass('selected') }
			$("tr#message-${Fmessage.list()[1].id}").hasClass('selected')
	}
	
	def "'Reply All' button appears for multiple selected messages and works"() {
		given:
			createInboxTestMessages()
			new Contact(name: 'Alice', primaryMobile: 'Alice').save(failOnError:true)
			new Contact(name: 'June', primaryMobile: '+254778899').save(failOnError:true)
		when:
			to SearchPage
			messagesSelect[1].click()
			messagesSelect[2].click()
		then:
			waitFor { replyToMultipleButton.displayed }
		when:
			replyToMultipleButton.click() // click the reply button
			$("div#tabs-1 .next").click()
		then:
			waitFor { $('input', value:'Alice').@checked }
			$('input', value:'Bob').@checked
			!$('input', value:'June').@checked
	}
	
	def "'Forward' button still work when all messages are unchecked"() {
		given:
			createInboxTestMessages()
			def message = Fmessage.findBySrc('Alice')
		when:
			to SearchPage
			messagesSelect[0].click()
		then:
			waitFor { messagesSelect*.@checked == ["true", "true", "true", "true"] }
		when:
			messagesSelect[0].click()
		then:
			waitFor { !messagesSelect*.@checked.any() }
		when:
			$('#btn_dropdown').click()
			$('#btn_forward').click()
		then:
			waitFor { $('textArea', name:'messageText').text() == "hi Alice" }
	}
	
	def "should set row as selected when a message is checked"() {
		given:
			createInboxTestMessages()
			def message = Fmessage.findBySrc('Bob')
		when:
			to SearchPage
			messagesSelect[2].click()
		then:
			waitFor { messagesSelect[2].@checked == "true" }
			messagesSelect[2].parent().parent().hasClass("selected")
	}


	def "select all should update the total message count when messages are checked"() {
		given:
			createInboxTestMessages()
			new Fmessage(src: "src", dst: "dst", status: MessageStatus.INBOUND).save(flush: true)
		when:
			to SearchPage
			messagesSelect[0].click()
		then:
			waitFor { multipleMessagesPanel.displayed }
			checkedMessageCountText == "3 messages selected"
		when:
			messagesSelect[1].click()
		then:
			waitFor { checkedMessageCountText == "2 messages selected" }
		when:
			messagesSelect[0].click()
		then:
			waitFor { checkedMessageCountText == "3 messages selected" }
	}
	
	def "can archive multiple messages where any owned messages are ignored, but those that are not are archived"() {
		given:
			createInboxTestMessages()
		when:
			to SearchForIPage
			messagesSelect[0].click()
		then:
			waitFor { archiveAllButton.displayed }
		when:
			archiveAllButton.click()
		then:
			waitFor { at SearchPage }
	}
}

class SearchForIPage extends SearchPage {
	static def url = "search/result?searchString=i"
}
