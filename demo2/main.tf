variable "myvar" {
 type = string
 default = "Hello world"
}

variable "myMap" {
 type = map(string)
 default = {
  myKey ="myValue"
	}
}
variable "myList" {
 type = list
 default = [1,2,3,4]
}

variable "mybool"{
 type = bool
 default =true
}

