import Foundation
import ReSwift

typealias SideEffect = (Action, @escaping DispatchFunction, @escaping () -> AppState?) -> Void

private let sideEffects: [SideEffect] = [
    mouseLocationSideEffect(),
    screenConfigurationSideEffect(),
]

let sideEffectsMiddleware: Middleware<AppState> = { dispatch, getState in
    return { originalDispatch in
        return { action in
            originalDispatch(action)
            for sideEffect in sideEffects {
                sideEffect(action, dispatch, getState)
            }
        }
    }
}
