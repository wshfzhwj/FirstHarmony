import socket from '@ohos.net.socket'

export class SocketDemo {
  tcpSocket() {
    let tcp = socket.constructTCPSocketInstance()
    tcp.on('message', data => {
      console.log('receive message')
      let buff = data.message
      let value = new DataView(buff)
      let msg = ''
      for (let i = 0;i < value.byteLength; i++) {
        msg += String.fromCharCode(value.getUint8(i))
      }
      console.log("received:" + msg)
    })

    tcp.on('connect', () => {
      console.log('establish connect')
    })
    tcp.on('close', () => {
      console.log('close connect')
    })

    let bindAddress = {
      address: '210.10.25.124',
      post: 52471,
      family: 1
    }

    tcp.bind(bindAddress, err => {
      if (err) {
        console.log('bind error')
      }
      console.log('bind ok')
      let connectAddress = {
        address: '10.12.37.221',
        post: 2512,
        family: 1
      }

      tcp.connect({
        address: connectAddress, timeout: 6000 }, err => {
        if (err) {
          console.log('connect error');
          return;
        }
        console.log('connect ok')
        tcp.send({ data: 'Hello ArkTS' }, err => {
          if (err) {
            console.log('send err');
            return;
          }
          console.log('send ok')
        })
      })
    })
    setTimeout(() => {
      tcp.close((() => {
        console.log('close socket.')
      }));
      tcp.off('message');
      tcp.off('connect');
      tcp.off('close');
    }, 30 * 1000)
  }
}