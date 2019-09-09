class Page {
    static controller() {
        return $('meta[name=psj]').attr('controller');
    }
    static action() {
        return $('meta[name=psj]').attr('action');
    }
}