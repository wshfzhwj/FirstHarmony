import { InnerBean } from '../../bean/InnerBean'

let storage = new LocalStorage(new InnerBean('Tom'))

@Entry(storage)
@Component
struct LocalStorageDemoIndex {
  // @LocalStorageProp('name') myName:string = ''
  @LocalStorageLink('name') myName:string = ''
  build() {
    Row() {
      Column() {
        Text(this.myName)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        //点击按钮后，只改变当前组件显示的myName，不会同步到LocalStorage中
        Button('更改名字').onClick(()=>{
          this.myName = 'jack'
        })
        //子组件Child
        Child()
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct Child {
  // @LocalStorageProp变量装饰器与LocalStorage中的'name'属性建立单向绑定
  // @LocalStorageProp('name') myName:string = ''
  @LocalStorageLink('name') myName:string = ''
  build() {
    Row(){
      //当父组件改变时，子组件不会改变，myName显示 'Tom'
      Text(`Child-${this.myName}`).fontSize(30)
    }
  }
}
