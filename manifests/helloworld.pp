# class invoke a notify

class pi::helloworld {
  notify { 'Hello from your raspberry pi':
    message => "Hello from ${::hostname}",
  }
}
