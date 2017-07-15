# variables used by this snippet of init shellcode
variable "version" {
    default = "0.8.5"
    description = "version of consul, to install"
}
variable "base_url" {
    default = "https://releases.hashicorp.com/consul"
    description = "string to prefix log messages with"
}
variable "data_dir" {
    default = "/opt/consul"
    description = "path to use for consul's -data-dir"
}
variable "init_prefix" {
    default = ""
    description = "initial init (shellcode) to prefix this snippet with"
}
variable "init_suffix" {
    default = ""
    description = "init (shellcode) to append to the end of this snippet"
}
variable "log_prefix" {
    default = "OPS: "
    description = "string to prefix log messages with"
}
# render init script snippet from the template
data "template_file" "init_snippet" {
    template = "${file("${path.module}/snippet.tpl")}"
    vars {
        version     = "${var.version}"
        base_url    = "${var.base_url}"
        data_dir    = "${var.data_dir}"
        init_prefix = "${var.init_prefix}"
        init_suffix = "${var.init_suffix}"
        log_prefix  = "${var.log_prefix}"
    }
}
output "init_snippet" {
    value = "${data.template_file.init_snippet.rendered}"
}
