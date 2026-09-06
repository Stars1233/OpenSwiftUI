//
//  ProgressViewUITests.swift
//  OpenSwiftUIUITests

import SnapshotTesting
import Testing
@testable import TestingHost

@MainActor
@Suite(.snapshots(record: .never, diffTool: diffTool))
struct ProgressViewUITests {
    @Test
    func valueBasedProgress() {
        openSwiftUIAssertSnapshot(of: ProgressViewExample())
    }

    // FIXME: TO BE INVEISTIGATE
    @Test(
        .disabled("The localized label is missing on CI sometimes"),
        .tags(.org_openswiftuiproject_openswiftui.localization)
    )
    func indeterminateInitializers() {
        openSwiftUIAssertSnapshot(of: IndeterminateProgressViewExample())
    }

    @Test(.disabled("TextLayoutManager is not implemented yet"))
    func defaultDateProgressLabelInitializers() {
        openSwiftUIAssertSnapshot(of: DefaultDateProgressLabelExample())
    }

    @Test
    func foundationProgress() {
        #if os(iOS)
        // FIXME: The SwiftUI reference image is flaky on CI while the Foundation progress label settles.
        withKnownIssue("The SwiftUI reference image is flaky on CI", isIntermittent: true) {
            openSwiftUIAssertSnapshot(of: FoundationProgressViewExample())
        }
        #else
        openSwiftUIAssertSnapshot(of: FoundationProgressViewExample())
        #endif
    }
}
