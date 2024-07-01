import socket from '@ohos.net.socket'

export class SocketTlsDemo {
  tlsSocket() {
    // 创建一个（双向认证）TLS Socket连接，返回一个TLS Socket对象。

    let tlsTwoWay: socket.TLSSocket = socket.constructTLSSocketInstance();

    // 设置通信过程中使用参数
    let options = {
      ALPNProtocols: ["spdy/1", "http/1.1"],

      // 连接到指定的IP地址和端口。
      address: {
        address: "192.168.xx.xxx",
        port: 8080, // 端口
        family: 1,
      },

      // 设置用于通信过程中完成校验的参数。
      secureOptions: {
        key: "xxxx", // 密钥
        cert: "xxxx", // 数字证书
        ca: ["xxxx"], // CA证书
        passwd: "xxxx", // 生成密钥时的密码
        protocols: [socket.Protocol.TLSv12], // 通信协议
        useRemoteCipherPrefer: true, // 是否优先使用对端密码套件
        signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256", // 签名算法
        cipherSuite: "AES256-SHA256", // 密码套件
      },
    };

    // 绑定本地IP地址和端口。
    tlsTwoWay.bind({ address: '192.168.xxx.xxx', port: 8080, family: 1 }, err => {
      if (err) {
        console.log('bind fail');
        return;
      }
      console.log('bind success');
      // 订阅TLS Socket相关的订阅事件
      tlsTwoWay.on('message', value => {
        console.log("on message")
        let buffer = value.message
        let dataView = new DataView(buffer)
        let str = ""
        for (let i = 0; i < dataView.byteLength; ++i) {
          str += String.fromCharCode(dataView.getUint8(i))
        }
        console.log("on connect received:" + str)
      });
      tlsTwoWay.on('connect', () => {
        console.log("on connect")
      });
      tlsTwoWay.on('close', () => {
        console.log("on close")
      });

      // 建立连接
      tlsTwoWay.connect(options).then(() => {
        console.log('connect success');

        // 发送数据
        let sendBuf = 'client send to server...';
        tlsTwoWay.send(sendBuf).then(() => {
          console.log('client send ok');
        }).catch((err: Object) => {
          console.error('client send err: ' + JSON.stringify(err));
        })
      }).catch((err: Object) => {
        console.log('connect failed ' + JSON.stringify(err));
      });

      // 连接使用完毕后，主动关闭。取消相关事件的订阅。
      tlsTwoWay.close().then(() => {
        console.log('close success');
      }).catch((err: Object) => {
        console.log('close failed ' + JSON.stringify(err));
      });
      tlsTwoWay.off('message');
      tlsTwoWay.off('connect');
      tlsTwoWay.off('close');
    });
  }
}