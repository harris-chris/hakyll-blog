{-# LANGUAGE OverloadedStrings #-}

import Control.Monad (forM_)
import Data.Maybe (fromMaybe)
import qualified Data.Text as T
import Hakyll
import Slug (toSlug)
import Text.Pandoc
  ( Extension (Ext_fenced_code_attributes, Ext_footnotes, Ext_gfm_auto_identifiers, Ext_implicit_header_references, Ext_smart),
    Extensions,
    ReaderOptions,
    WriterOptions,
    extensionsFromList,
    githubMarkdownExtensions,
    readerExtensions,
    writerExtensions,
  )

-- CONFIG

root :: String
root =
  "https://rpearce.github.io/hakyll-nix-template"

siteName :: String
siteName =
  "Abstract Nonsense"

config :: Configuration
config =
  defaultConfiguration
    { destinationDirectory = "../dist",
      ignoreFile = const False,
      previewHost = "127.0.0.1",
      previewPort = 8000,
      providerDirectory = "../src",
      storeDirectory = "../hakyll-cache",
      tmpDirectory = "../hakyll-cache/tmp"
    }

-- BUILD

{- ORMOLU_DISABLE -}

main :: IO ()
main = hakyllWith config $ do
  forM_
    [ "CNAME",
      "favicon.ico",
      "robots.txt",
      "_config.yml",
      "images/*",
      "js/*",
      "fonts/*"
    ]
    $ \f -> match f $ do
      route idRoute
      compile copyFileCompiler
  match "css/*" $ do
    route idRoute
    compile compressCssCompiler
  match "fonts/*" $ do
    route   idRoute
    compile copyFileCompiler
  match "content/thoughts/*" $ do
    let ctx = constField "type" "article" <> thoughtCtx
    route $ metadataRoute titleRoute
    compile $
      pandocCompilerCustom
        >>= loadAndApplyTemplate "templates/thought.html" ctx
        >>= saveSnapshot "content"
        >>= loadAndApplyTemplate "templates/default.html" ctx
  match "content/deeds/*" $ do
    let ctx = constField "type" "article" <> deedCtx
    route $ metadataRoute titleRoute
    compile $
      pandocCompilerCustom
        >>= loadAndApplyTemplate "templates/deed.html" ctx
        >>= saveSnapshot "content"
        >>= loadAndApplyTemplate "templates/default.html" ctx
  match "index.html" $ do
    route idRoute
    compile $ do
      thoughts <- recentFirst =<< loadAll "content/thoughts/*"
      let indexCtx =
            listField "thoughts" thoughtCtx (return thoughts)
              <> constField "root" root
              <> constField "siteName" siteName
              <> defaultContext
      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx
  match "thoughts.html" $ do
    route idRoute
    compile $ do
      thoughts <- recentFirst =<< loadAll "content/thoughts/*"
      let indexCtx =
            listField "thoughts" thoughtCtx (return thoughts)
              <> constField "root" root
              <> constField "siteName" siteName
              <> defaultContext
      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx
  match "me.html" $ do
    route idRoute
    compile $ do
      let meCtx = defaultContext <> constField "siteName" siteName <> constField "root" root
      getResourceBody
        >>= applyAsTemplate meCtx
        >>= loadAndApplyTemplate "templates/default.html" meCtx
  match "deeds.html" $ do
    route idRoute
    compile $ do
      deeds <- recentFirst =<< loadAll "content/deeds/*"
      let indexCtx =
            listField "deeds" deedCtx (return deeds)
              <> constField "root" root
              <> constField "siteName" siteName
              <> defaultContext
      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx
  match "templates/*" $
    compile templateBodyCompiler
  create ["sitemap.xml"] $ do
    route idRoute
    compile $ do
      content <- recentFirst =<< loadAll "content/*"
      let pages = content
          sitemapCtx =
            constField "root" root
              <> constField "siteName" siteName
              <> listField "pages" thoughtCtx (return pages)
      makeItem ("" :: String)
        >>= loadAndApplyTemplate "templates/sitemap.xml" sitemapCtx
  create ["rss.xml"] $ do
    route idRoute
    compile (feedCompiler renderRss)
  create ["atom.xml"] $ do
    route idRoute
    compile (feedCompiler renderAtom)

{- ORMOLU_ENABLE -}

-- CONTEXT

feedCtx :: Context String
feedCtx =
  titleCtx
    <> thoughtCtx
    <> bodyField "description"

thoughtCtx :: Context String
thoughtCtx =
  constField "root" root
    <> constField "siteName" siteName
    <> dateField "date" "%Y-%m-%d"
    <> defaultContext

deedCtx :: Context String
deedCtx =
  constField "root" root
    <> constField "siteName" siteName
    <> dateField "date" "%Y-%m-%d"
    <> defaultContext

titleCtx :: Context String
titleCtx =
  field "title" updatedTitle

-- TITLE HELPERS

replaceAmp :: String -> String
replaceAmp =
  replaceAll "&" (const "&amp;")

replaceTitleAmp :: Metadata -> String
replaceTitleAmp =
  replaceAmp . safeTitle

safeTitle :: Metadata -> String
safeTitle =
  fromMaybe "no title" . lookupString "title"

updatedTitle :: Item a -> Compiler String
updatedTitle =
  fmap replaceTitleAmp . getMetadata . itemIdentifier

-- PANDOC

pandocCompilerCustom :: Compiler (Item String)
pandocCompilerCustom =
  pandocCompilerWith pandocReaderOpts pandocWriterOpts

pandocExtensionsCustom :: Extensions
pandocExtensionsCustom =
  githubMarkdownExtensions
    <> extensionsFromList
      [ Ext_fenced_code_attributes,
        Ext_gfm_auto_identifiers,
        Ext_implicit_header_references,
        Ext_smart,
        Ext_footnotes
      ]

pandocReaderOpts :: ReaderOptions
pandocReaderOpts =
  defaultHakyllReaderOptions
    { readerExtensions = pandocExtensionsCustom
    }

pandocWriterOpts :: WriterOptions
pandocWriterOpts =
  defaultHakyllWriterOptions
    { writerExtensions = pandocExtensionsCustom
    }

-- FEEDS

type FeedRenderer =
  FeedConfiguration ->
  Context String ->
  [Item String] ->
  Compiler (Item String)

feedCompiler :: FeedRenderer -> Compiler (Item String)
feedCompiler renderer =
  renderer feedConfiguration feedCtx
    =<< recentFirst
    =<< loadAllSnapshots "content/*" "content"

feedConfiguration :: FeedConfiguration
feedConfiguration =
  FeedConfiguration
    { feedTitle = "My Site",
      feedDescription = "My Site Description",
      feedAuthorName = "My Name",
      feedAuthorEmail = "me@myemail.com",
      feedRoot = root
    }

-- CUSTOM ROUTE

getTitleFromMeta :: Metadata -> String
getTitleFromMeta =
  fromMaybe "no title" . lookupString "title"

fileNameFromTitle :: Metadata -> FilePath
fileNameFromTitle =
  T.unpack . (`T.append` ".html") . toSlug . T.pack . getTitleFromMeta

titleRoute :: Metadata -> Routes
titleRoute =
  constRoute . fileNameFromTitle
