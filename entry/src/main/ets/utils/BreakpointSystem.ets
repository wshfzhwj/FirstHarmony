import mediaQuery from '@ohos.mediaquery'
import BreakpointConstants from '../constants/BreakpointConstants'

export default class BreakpointSystem {
  private smListener: mediaQuery.MediaQueryListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_SM)
  private mdListener: mediaQuery.MediaQueryListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_MD)
  private lgListener: mediaQuery.MediaQueryListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_LG)

  smListenerCallback(result: mediaQuery.MediaQueryResult) {
    if (result.matches) {
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_SM)
    }
  }

  mdListenerCallback(result: mediaQuery.MediaQueryResult) {
    if (result.matches) {
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_MD)
    }
  }

  lgListenerCallback(result: mediaQuery.MediaQueryResult) {
    if (result.matches) {
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_LG)
    }
  }

  updateCurrentBreakpoint(breakpoint: string) {
    AppStorage.setOrCreate(BreakpointConstants.CURRENT_BREAKPOINT, breakpoint)
  }

  register() {
    this.smListener.on('change', (result: mediaQuery.MediaQueryResult) => {
      this.smListenerCallback(result)
    })
    this.mdListener.on('change', (result: mediaQuery.MediaQueryResult) => {
      this.mdListenerCallback(result)
    })
    this.lgListener.on('change', (result: mediaQuery.MediaQueryResult) => {
      this.lgListenerCallback(result)
    })
  }

  unregister() {
    this.smListener.off('change', (result: mediaQuery.MediaQueryResult) => {
      this.smListenerCallback(result)
    })
    this.mdListener.off('change', (result: mediaQuery.MediaQueryResult) => {
      this.mdListenerCallback(result)
    })
    this.lgListener.off('change', (result: mediaQuery.MediaQueryResult) => {
      this.lgListenerCallback(result)
    })
  }
}