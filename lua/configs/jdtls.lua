local status = pcall(require, "jdtls")
if not status then
  return
end

local on_attach = function(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach(client, bufnr)
end

local capabilities = require("nvchad.configs.lspconfig").capabilities
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local env = {
  HOME = vim.uv.os_homedir(),
  XDG_CACHE_HOME = os.getenv "XDG_CACHE_HOME",
  JDTLS_JVM_ARGS = os.getenv "JDTLS_JVM_ARGS",
}

local function get_cache_dir()
  return env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or env.HOME .. "/.cache"
end

local function get_jdtls_cache_dir()
  return get_cache_dir() .. "/jdtls"
end

local function get_jdtls_config_dir()
  return get_jdtls_cache_dir() .. "/config"
end

local function get_jdtls_workspace_dir()
  return get_jdtls_cache_dir() .. "/workspace"
end
-- calculate workspace dir
-- local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
local workspace_dir = get_jdtls_workspace_dir() .. "/" .. project_name

-- -- get the mason install path
-- local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
-- -- get the debug adapter install path
-- local debug_install_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()
-- local bundles = {
-- 	vim.fn.glob(debug_install_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
-- }

-- Comment out these lines if you have 'java-test' installed
-- local java_test_path = require("mason-registry").get_package("java-test"):get_install_path()
-- vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))

local config = {
  cmd = {
    "jdtls",
    -- "--jvm-arg=-javaagent:" .. install_path .. "/lombok.jar",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1G",
    "-Xmx2G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-configuration",
    get_jdtls_config_dir(),
    "-data",
    workspace_dir,
  },
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = vim.fs.dirname(
    vim.fs.find({ ".gradlew", ".git", "mvnw", "pom.xml", "build.gradle" }, { upward = true })[1]
  ),
  single_file_support = true,

  settings = {
    java = {
      signatureHelp = { enabled = true },
    },
  },
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function(ev)
    local name = vim.api.nvim_buf_get_name(ev.buf)
    -- Block jdtls from starting on conform temp files
    -- Example: foo.md.1.java, bar.md.23.java
    if name:match "%.md%.[0-9]+%.java$" then
      return
    end

    require("jdtls").start_or_attach(config)
  end,
})
