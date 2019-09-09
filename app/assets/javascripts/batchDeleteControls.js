$(document).on('turbolinks:load', () => {
    if(Page.controller() === 'tasks' &&
        (Page.action() === 'active'
            || Page.action() === 'completed'
            || Page.action() === 'index')) {
        const checkboxes = $('[data-task-to-delete-checkbox=true]');
        if(checkboxes.length === 0) return;
        const checkBtn = $('#check-all-tasks');
        const uncheckBtn = $('#uncheck-all-tasks');
        const deleteSelectedBtn = $('#delete-selected-button');
        let checkedCheckboxes = 0;
        checkBtn.click(() => {
            checkboxes.prop( "checked", true );
            respawnButton();
            checkedCheckboxes = checkboxes.length;
        });
        uncheckBtn.click(() => {
            checkboxes.prop( "checked", false );
            hideButton();
            checkedCheckboxes = 0;
        });
        checkboxes.change(function() {
            if(this.checked){
                checkedCheckboxes++;
            } else {
                checkedCheckboxes--;
            }
            if(checkedCheckboxes > 0) {
                respawnButton();
            } else {
                hideButton();
            }

        });
        function respawnButton(){
            if(deleteSelectedBtn.css('display') === 'none'){
                deleteSelectedBtn.show();
            }
        }
        function hideButton(){
            if(deleteSelectedBtn.css('display') !== 'none'){
                deleteSelectedBtn.hide();
            }
        }
    }
});