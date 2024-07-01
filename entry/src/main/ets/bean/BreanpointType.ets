import BreakpointConstants from '../constants/BreakpointConstants'

declare interface BreakpointTypeOptions<T> {
  sm: T,
  md: T,
  lg: T
}

export default  class BreakpointType<T> {
  options: BreakpointTypeOptions<T>

  constructor(options: BreakpointTypeOptions<T>) {
    this.options = options
  }

  getValue(breakpoint: string): T {
    if (breakpoint === BreakpointConstants.BREAKPOINT_SM) {
      return this.options.sm
    } else if (breakpoint === BreakpointConstants.BREAKPOINT_MD) {
      return this.options.md
    } else {
      return this.options.lg
    }
  }
}