public import GhosttyKit

/// The one sanctioned seam for libghostty runtime symbols that the cmux fork
/// exports beyond upstream Ghostty's C API.
///
/// Each symbol is exposed as a static member here so fork-specific FFI
/// bindings live behind a single type instead of being scattered through the
/// codebase. Bindings go through the `ghostty.h` import: a `@_silgen_name`
/// redeclaration of a header symbol collides with the clang import once
/// cross-module optimization serializes this module's SIL and crashes
/// swift-frontend in Release builds.
// lint:allow namespace-type — sanctioned FFI seam: a holder for fork-specific
// libghostty bindings; there is nothing to instantiate.
public struct GhosttyRuntimeCInterop {
    private init() {}

    /// Clears the active selection on a runtime surface.
    ///
    /// Mirrors `ghostty_surface_clear_selection` from the cmux libghostty
    /// fork. The surface pointer must be a live `ghostty_surface_t`; passing a
    /// freed pointer is undefined behavior, exactly as with any other ghostty
    /// C call.
    ///
    /// - Parameter surface: The live runtime surface to clear.
    /// - Returns: Whether the runtime cleared a selection.
    @discardableResult
    public static func clearSelection(_ surface: ghostty_surface_t) -> Bool {
        ghostty_surface_clear_selection(surface)
    }

}
