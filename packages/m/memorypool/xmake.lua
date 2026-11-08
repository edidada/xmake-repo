package("memorypool")

    set_homepage("https://github.com/edidada/MyMemoryPool")
    set_description("A small free-list / slab-style C memory pool allocator (toy project).")
    set_license("MIT")

    add_urls("https://github.com/edidada/MyMemoryPool/archive/refs/tags/$(version).tar.gz",
             "https://github.com/edidada/MyMemoryPool.git")
    add_versions("1.0.0", "77e19c9f771c0755c8d01344a3dc7ae6aa5a58cc17705ac729cbac6b2c5e9a87")

    add_configs("shared", {description = "Build shared library.", default = false, type = "boolean", readonly = true})

    add_deps("cmake")

    on_install("windows", "linux", "macosx", "mingw", function (package)
        local configs = {"-DBUILD_TESTING=OFF"}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:is_debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
        import("package.tools.cmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("mempool_create", {includes = "mempool.h"}))
    end)
