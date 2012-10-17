<div class="generic_sorting_tab">
	<h2><g:message code="activity.generic.sort.header"/></h2>
	<div class="info">
		<p><g:message code="activity.generic.sort.description"/></p>
	</div>
	<div class="input">
		<label for="keywords"><g:message code="activity.generic.keywords.title"/></label>
		<g:textField name="keywords" class="required validcommas sorting-generic-unique sorting-generic-no-spaces" value="${activityInstanceToEdit?.keywords? activityInstanceToEdit?.keywords*.value.join(',') : ''}" disabled="${(activityInstanceToEdit?.keywords.size() == 1) && (activityInstanceToEdit?.keywords[0].value == '')}"/>
	</div>
	<div class="input optional">
		<label for="blankKeyword"><g:message code="activity.generic.no.keywords"/></label>
		<g:checkBox name="blankKeyword" checked="${(activityInstanceToEdit?.keywords.size() == 1) && (activityInstanceToEdit?.keywords[0].value == '')}"/>
	</div>
	<r:script>
	$(function() {
		$('#blankKeyword').live("change", function() {
			if($(this).is(":checked")) {
				$("#keywords").attr("disabled", "disabled");
				$("#keywords").removeClass("required error");
				$(".error").hide();
			} else {
				$("#keywords").attr("disabled", false);
				$("#keywords").addClass("required");
			}
		});
	});
	</r:script>
</div>