@Entry
@Component
struct ComponentA {
  @State count: number = 0

  fun(): void {
    console.log("do something in fun")
    this.count++
  }
  fun2(): void {
    console.log("do something in fun")
    this.count++
  }

  build() {
    Column() {
      Text(`count:${this.count}`).fontSize(25)
      Row() {
        Button('直接调用')
          .layoutWeight(1)
          .onClick(() => {
            this.count++
          })
        Button('bind this')
          .layoutWeight(1)
          .onClick(this.fun.bind(this)) //不bind，不能访问this.count
        Button('匿名函数')
          .layoutWeight(1)
          .onClick(this.fun2.bind(this))
      }.width('100%')

      ChildComponent({
        count: $count, fun: () => {
          this.fun()
        }
      }).margin({ top: 20 })
    }.width('100%')
  }

  onPageShow(): void {
    console.log("onPageShow")
  }

  onPageHide(): void {
    console.log("onPageHide")
  }

  onBackPress(): void {
    console.log("onBackPress")
  }

  aboutToAppear(): void {
    console.log("parent aboutToAppear")
  }

  aboutToDisappear(): void {
    console.log("parent aboutToAppear")
  }
}

@Component
struct ChildComponent {
  fun: () => void = () => {
  }

  fun2(){
    this.count++
    console.log("do something")
  }
  @Link count: number

  build() {
    Column({ space: 20 }) {
      Text('下面是子组件')
      Flex({
        direction: FlexDirection.Row,
        alignItems: ItemAlign.Center,
        justifyContent: FlexAlign.SpaceEvenly
      }) {
        Button('单击1')
          .onClick(() => {
            this.fun()
          })
        Button('单击2')
          .onClick(this.fun2.bind(this))
      }
    }.borderWidth(1)
  }

  aboutToAppear(): void {
    console.log("child aboutToAppear")
  }

  aboutToDisappear(): void {
    console.log("child aboutToAppear")
  }
}
