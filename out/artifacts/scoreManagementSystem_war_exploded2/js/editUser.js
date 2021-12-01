$(function (){
    function setData(data){
        $('#edit_account').val(data.account)
        $('#edit_password').val(data.password)
        $('#edit_name').val(data.name)
        $('#edit_status').val(data.status)
    }

    function getData(){
        let rData = {
            'account': $('#edit_account').val(),
            'password': $('#edit_password').val(),
            'name': $('#edit_name').val(),
            'status': $('#edit_status').val()
        };
        return rData;
    }
});