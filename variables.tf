# Variables

variable "vpc_cidr_block" {
  type = string
}

variable "snet_pub01_cidr_block" {
  type = string
}

variable "snet_pub02_cidr_block" {
  type = string
}

variable "snet_priv01_cidr_block" {
  type = string
}

variable "snet_priv02_cidr_block" {
  type = string
}

variable "ami" {
  type = string
}

variable "keyName" {
  type = string
}